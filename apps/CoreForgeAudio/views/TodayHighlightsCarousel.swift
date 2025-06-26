#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Dynamic AI-powered daily suggestions carousel.
struct TodayHighlightsCarousel: View {
    var books: [Book]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Today's Highlights")
                .font(.headline)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(books.prefix(5)) { book in
                        Rectangle()
                            .fill(AppTheme.primaryGradient)
                            .frame(width: 120, height: 160)
                            .overlay(Text(book.title).font(.caption).foregroundColor(.white).padding(4), alignment: .bottomLeading)
                            .cornerRadius(8)
                    }
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
    TodayHighlightsCarousel(books: LibraryModel().books)
}
#endif
