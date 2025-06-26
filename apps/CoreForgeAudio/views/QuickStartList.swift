#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Displays three most recent books for instant access.
struct QuickStartList: View {
    var books: [Book]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Quick Start")
                .font(.headline)
                .padding(.horizontal)
            ForEach(books) { book in
                HStack {
                    Text(book.title)
                    Spacer()
                    NavigationLink("Open") {
                        BookDetailView(book: book)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }
}

#Preview {
    QuickStartList(books: LibraryModel().books)
}
#endif
