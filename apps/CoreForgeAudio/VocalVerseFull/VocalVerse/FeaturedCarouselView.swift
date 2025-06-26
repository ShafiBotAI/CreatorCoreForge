#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Horizontal carousel showing featured books.
struct FeaturedCarouselView: View {
    var books: [Book]
    @State private var showPreview = false
    @State private var previewURL: URL?

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
                            if let url = chapter.audioURL {
                                Button(chapter.title) {
                                    previewURL = url
                                    showPreview = true
                                }
                            }
                        }
                    }
                    .swipeActions {
                        if let url = book.chapters.first?.audioURL {
                            Button {
                                previewURL = url
                                showPreview = true
                            } label: {
                                Label("Preview", systemImage: "play.fill")
                            }
                            .tint(.green)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showPreview) {
            if let url = previewURL {
                VoicePreviewPopup(audioURL: url, isPresented: $showPreview)
            }
        }
    }
}
#endif
