#if canImport(SwiftUI)
import SwiftUI

/// ConnectView lists available ebook services powered by public APIs.
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
