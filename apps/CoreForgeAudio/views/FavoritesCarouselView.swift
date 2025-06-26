#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Carousel row for books marked as favorites.
struct FavoritesCarouselView: View {
    @EnvironmentObject var library: LibraryModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(library.favoriteBooks) { book in
                    VStack(alignment: .leading) {
                        Rectangle()
                            .fill(AppTheme.primaryGradient)
                            .frame(width: 120, height: 160)
                            .overlay(
                                Text(book.title)
                                    .font(.caption)
                                    .foregroundColor(.primary)
                                    .padding(4),
                                alignment: .bottomLeading
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

#Preview {
    FavoritesCarouselView()
        .environmentObject(LibraryModel())
}
#endif
