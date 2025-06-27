#if canImport(SwiftUI)
import SwiftUI

/// Displays a list of sample Kindle books and allows downloading them
/// into the local library.
struct KindleView: View {
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats
    private let service = KindleService()
    @State private var books: [KindleBook] = []
    @State private var loading = false

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
                        service.download(book: book) { newBook in
                            if let newBook = newBook {
                                DispatchQueue.main.async {
                                    library.addBook(newBook)
                                    usage.recordImport()
                                }
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Kindle")
            .onAppear {
                loading = true
                service.fetchAvailableBooks { result in
                    DispatchQueue.main.async {
                        books = result
                        loading = false
                    }
                }
            }
        }
    }
}

#Preview {
    KindleView()
        .environmentObject(LibraryModel())
        .environmentObject(UsageStats())
}
#endif
