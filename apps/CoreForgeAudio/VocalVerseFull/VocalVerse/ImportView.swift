#if canImport(SwiftUI)
import SwiftUI

/// Placeholder import screen for eBook files.
struct ImportView: View {
    @State private var showingImporter = false
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats

    var body: some View {
        VStack(spacing: 20) {
            Button("Import Book") { showingImporter = true }
                .buttonStyle(.borderedProminent)
            if !library.books.isEmpty {
                List(library.books) { book in
                    Text(book.title)
                }
            }
        }
        .fileImporter(isPresented: $showingImporter,
                      allowedContentTypes: [.pdf, .epub, .plainText],
                      allowsMultipleSelection: false) { result in
            switch result {
            case .success(let urls):
                if let url = urls.first {
                    let chapters = EbookImporter().importEbook(from: url.path).map { Chapter(title: "Chapter", text: $0) }
                    let book = Book(title: url.lastPathComponent, author: "", chapters: chapters)
                    library.addBook(book)
                    usage.recordImport()
                }
            case .failure:
                break
            }
        }
    }
}

#Preview {
    ImportView()
        .environmentObject(LibraryModel())
        .environmentObject(UsageStats())
}
#endif
