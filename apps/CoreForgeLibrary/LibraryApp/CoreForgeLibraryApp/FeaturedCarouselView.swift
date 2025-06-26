#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Horizontal carousel showing featured books at the top of the library.
struct FeaturedCarouselView: View {
    var books: [Book]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(books) { book in
                    VStack(alignment: .leading) {
                        Rectangle()
                            .fill(AppTheme.primaryGradient)
                            .frame(width: 120, height: 160)
                            .overlay(
                                Text(book.title)
                                    .font(.caption)
                                    .padding(4)
                                    .foregroundColor(.white),
                                alignment: .bottom
                            )
                    }
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
    }
}
#endif

