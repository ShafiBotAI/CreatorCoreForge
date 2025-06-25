#if canImport(SwiftUI)
import SwiftUI

/// ConnectView lists available ebook services such as Kindle or Apple Books.
struct ConnectView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: KindleView()) {
                    Label("Kindle", systemImage: "book.fill")
                }
                NavigationLink(destination: AppleBooksView()) {
                    Label("Apple Books", systemImage: "book.circle")
                }
            }
            .navigationTitle("Connect")
        }
    }
}
#endif
