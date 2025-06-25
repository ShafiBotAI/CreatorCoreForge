#if canImport(SwiftUI)
import SwiftUI

/// Displays a list of sample Kindle books and allows downloading them
/// into the local library.
struct KindleView: View {
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats
    private let service = KindleService()
    @State private var books: [KindleBook] = []

    var body: some View {
        NavigationView {
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
            .navigationTitle("Kindle")
            .onAppear {
                books = service.fetchAvailableBooks()
            }
        }
    }
}
#endif
