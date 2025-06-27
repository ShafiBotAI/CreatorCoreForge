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
        default:
            message = "Import from \(source.title) coming soon"
            showMessage = true
        }
    }

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
