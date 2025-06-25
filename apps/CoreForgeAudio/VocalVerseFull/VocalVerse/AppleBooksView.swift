#if canImport(SwiftUI)
import SwiftUI

/// Displays a list of sample Apple Books and allows downloading them
/// into the local library.
struct AppleBooksView: View {
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats
    private let service = AppleBooksService()
    @State private var books: [AppleBook] = []

    var body: some View {
        List(books) { book in
            HStack {
                VStack(alignment: .leading) {
                    Text(book.title)
                    Text(book.author).font(.caption)
                }
                Spacer()
                Button("Download") {
                    let newBook = service.download(book: book)
                    library.addBook(newBook)
                    usage.recordImport()
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle("Apple Books")
        .onAppear {
            books = service.fetchAvailableBooks()
        }
    }
}
#endif
