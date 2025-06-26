#if canImport(SwiftUI)
import SwiftUI

/// Simple manager for downloaded content.
struct DownloadsView: View {
    var books: [Book]
    var body: some View {
        List(books.filter { $0.isDownloaded }) { book in
            Text(book.title)
        }
        .navigationTitle("Downloads")
    }
}
#endif
