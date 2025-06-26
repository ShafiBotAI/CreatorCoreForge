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
                            .fill(AppTheme.primaryGradient)
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
                    .background(AppTheme.cardMaterial)
                    .cornerRadius(AppTheme.cornerRadius)
                    .shadow(radius: AppTheme.shadowRadius)
                }
            }
            .padding(.horizontal)
        }
    }
}
#endif
