#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Horizontal carousel showing featured books.
struct FeaturedCarouselView: View {
    var books: [Book]
    @EnvironmentObject var library: LibraryModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(books) { book in
                    VStack(alignment: .leading) {
                        Rectangle()
                            .fill(Theme.primaryGradient)
                            .frame(width: 120, height: 160)
                            .overlay(
                                VStack(alignment: .leading) {
                                    HStack {
                                        if book.isDownloaded {
                                            Image(systemName: "arrow.down.circle")
                                        }
                                        Spacer()
                                        Button(action: { library.toggleFavorite(book: book) }) {
                                            Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                                                .foregroundColor(.red)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                    Spacer()
                                    Text(book.title)
                                    .font(.caption)
                                    .foregroundColor(.primary)
                                }
                                .padding(4),
                                alignment: .bottom
                            )
                    }
                    .background(Theme.cardMaterial)
                    .cornerRadius(Theme.cornerRadius)
                    .shadow(radius: Theme.shadowRadius)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    FeaturedCarouselView(books: [
        Book(title: "Sample", author: "A", series: nil),
        Book(title: "Sample 2", author: "B", series: nil)
    ])
    .environmentObject(LibraryModel())
}
#endif
