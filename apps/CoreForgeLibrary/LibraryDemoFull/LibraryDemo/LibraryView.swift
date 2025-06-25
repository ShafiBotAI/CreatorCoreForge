import Foundation
#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

struct LibraryView: View {
    @State private var books: [String] = []
    let userID: String
    private let sync = LibrarySync()

    var body: some View {
        List(books, id: \.self) { book in
            Text(book)
        }
        .onAppear {
            sync.fetch(userID: userID) { progress in
                DispatchQueue.main.async {
                    books = progress?.map { $0.key } ?? []
                }
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(userID: "1")
    }
}
#endif
