#if canImport(SwiftUI)
import SwiftUI

struct LibraryView: View {
    @State private var books: [Book] = [
        Book(title: "Sample Adventure", author: "A. Author", coverImage: nil, chapters: [
            Chapter(title: "Intro", text: "@Hero begins the journey."),
            Chapter(title: "Conflict", text: "@Villain appears in town.")
        ])
    ]

    var body: some View {
        NavigationView {
            List(books) { book in
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
