#if canImport(SwiftUI)
import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var library: LibraryModel

    var body: some View {
        NavigationView {
            List(library.books) { book in
                NavigationLink(destination: BookDetailView(book: book)) {
                    VStack(alignment: .leading) {
                        Text(book.title)
                        Text(book.author).font(.caption)
                    }
                }
            }
            .navigationTitle("Library")
        }
    }
}
#endif
