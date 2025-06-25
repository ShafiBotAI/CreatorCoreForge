#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Horizontal carousel showing featured books.
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
                                VStack(alignment: .leading) {
                                    HStack {
                                        if book.isDownloaded {
                                            Image(systemName: "arrow.down.circle")
                                        }
                                        Spacer()
                                    }
                                    Spacer()
                                    Text(book.title)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                                .padding(4),
                                alignment: .bottom
                            )
                    }
                    .cornerRadius(8)
                    .contextMenu {
                        ForEach(book.chapters) { chapter in
                            Button(chapter.title) {
                                // Preview voice snippet placeholder
                            }
                        }
                    }
                    .swipeActions {
                        Button {
                            // play preview placeholder
                        } label: {
                            Label("Preview", systemImage: "play.fill")
                        }
                        .tint(.green)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
#endif
