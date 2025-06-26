#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Collapsed player pinned to the bottom of `LibraryView`.
struct MiniPlayerView: View {
    var book: Book
    var chapter: Chapter
    @Binding var isExpanded: Bool
    @State private var isPlaying = false
    @State private var speed: Double = 1.0
    @Namespace private var ns

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.subheadline)
                Text(chapter.title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button(action: { isPlaying.toggle() }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
            }
            PlaybackSpeedControlView(speed: $speed)
        }
        .padding()
        .background(AppTheme.primaryGradient)
        .cornerRadius(12)
        .matchedGeometryEffect(id: "player", in: ns)
        .onTapGesture { isExpanded = true }
    }
}
#endif

