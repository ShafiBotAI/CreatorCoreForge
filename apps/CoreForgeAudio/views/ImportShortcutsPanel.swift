#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Buttons for importing from various sources.
struct ImportShortcutsPanel: View {
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats
    @State private var showMessage = false
    @State private var message = ""
    @State private var showImporter = false
    @State private var showURLSheet = false
    @State private var urlString = ""
    @State private var showScanner = false

    var body: some View {
        HStack {
            ForEach(Source.allCases, id: \.self) { source in
                Button(action: { handle(source) }) {
                    VStack {
                        Image(systemName: source.icon)
                        Text(source.title).font(.caption2)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
        .alert(message, isPresented: $showMessage) {
            Button("OK", role: .cancel) {}
        }
        .sheet(isPresented: $showURLSheet) {
            NavigationStack {
                VStack(spacing: 20) {
                    TextField("https://example.com/book.epub", text: $urlString)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.URL)
                    Button("Import") {
                        importFromURL(urlString)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .navigationTitle("Import from Web")
                .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Cancel") { showURLSheet = false } } }
            }
        }
        .sheet(isPresented: $showScanner) {
            #if canImport(VisionKit)
            DocumentScannerView { text in
                let chapter = Chapter(title: "Scan", text: text)
                let book = Book(title: "Scanned Document", author: "", chapters: [chapter])
                library.addBook(book)
                usage.recordImport()
            }
            #else
            Text("Scanning not supported on this device")
                .padding()
            #endif
        }
        .fileImporter(isPresented: $showImporter,
                      allowedContentTypes: [.pdf, .epub, .plainText],
                      allowsMultipleSelection: false) { result in
            switch result {
            case .success(let urls):
                guard let url = urls.first else { return }
                Task {
                    do {
                        let chapters = try await BookImporter.importBook(from: url)
                        let book = Book(title: url.deletingPathExtension().lastPathComponent,
                                        author: "",
                                        chapters: chapters)
                        library.addBook(book)
                        usage.recordImport()
                    } catch {
                        message = "Failed to import: \(error.localizedDescription)"
                        showMessage = true
                    }
                }
            case .failure(let error):
                message = error.localizedDescription
                showMessage = true
            }
        }
    }

    private func handle(_ source: Source) {
        switch source {
        case .files:
            showImporter = true
        case .web:
            showURLSheet = true
        case .gmail:
            openExternal(url: URL(string: "https://mail.google.com")!)
        case .scan:
            #if canImport(VisionKit)
            showScanner = true
            #else
            message = "Scanning not supported on this device"
            showMessage = true
            #endif
        case .links:
            #if canImport(UIKit)
            if let str = UIPasteboard.general.string {
                importFromURL(str)
            } else {
                message = "No link found on clipboard"
                showMessage = true
            }
            #else
            message = "Clipboard import unavailable"
            showMessage = true
            #endif
        }
    }

    private func importFromURL(_ str: String) {
        guard let remoteURL = URL(string: str) else {
            message = "Invalid URL"
            showMessage = true
            return
        }
        showURLSheet = false
        Task {
            do {
                let (localURL, _) = try await URLSession.shared.download(from: remoteURL)
                let chapters = try await BookImporter.importBook(from: localURL)
                let title = remoteURL.deletingPathExtension().lastPathComponent
                let book = Book(title: title, author: "", chapters: chapters)
                library.addBook(book)
                usage.recordImport()
            } catch {
                message = "Failed to import: \(error.localizedDescription)"
                showMessage = true
            }
        }
    }

    #if canImport(UIKit)
    @Environment(\.openURL) private var openURLAction
    private func openExternal(url: URL) { openURLAction(url) }
    #elseif canImport(AppKit)
    private func openExternal(url: URL) { NSWorkspace.shared.open(url) }
    #else
    private func openExternal(url: URL) {}
    #endif

    enum Source: CaseIterable {
        case files, web, gmail, scan, links
        var title: String {
            switch self { case .files: return "Files"; case .web: return "Web"; case .gmail: return "Gmail"; case .scan: return "Scan"; case .links: return "Links" }
        }
        var icon: String {
            switch self { case .files: return "doc"; case .web: return "globe"; case .gmail: return "envelope"; case .scan: return "camera.viewfinder"; case .links: return "link" }
        }
    }
}

#Preview {
    ImportShortcutsPanel()
        .environmentObject(LibraryModel())
        .environmentObject(UsageStats())
}
#endif
