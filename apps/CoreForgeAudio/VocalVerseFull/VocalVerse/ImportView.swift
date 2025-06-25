#if canImport(SwiftUI)
import SwiftUI

/// Placeholder import screen for eBook files.
struct ImportView: View {
    @State private var showingImporter = false
    @State private var importedBooks: [Book] = []

    var body: some View {
        VStack(spacing: 20) {
            Button("Import Book") { showingImporter = true }
                .buttonStyle(.borderedProminent)
            if !importedBooks.isEmpty {
                List(importedBooks) { book in
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
                    importedBooks.append(book)
                }
            case .failure:
                break
            }
        }
    }
}
#endif
