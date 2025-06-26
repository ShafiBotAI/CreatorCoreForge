#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Collapsed player pinned to the bottom of `LibraryDashboardView`.
struct MiniPlayerView: View {
    var book: Book
    var chapter: Chapter
    var namespace: Namespace.ID
    @Binding var isExpanded: Bool
    @State private var isPlaying = false
    @State private var speed: Double = 1.0
    @State private var voice: String = VoiceConfig.voices.first?.name ?? "Default"

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
            PlaybackSpeedControlView(speed: $speed, voice: $voice)
        }
        .padding()
        .background(AppTheme.primaryGradient)
        .cornerRadius(12)
        .shadow(radius: 4)
        .matchedGeometryEffect(id: "player", in: namespace)
        .onTapGesture { isExpanded = true }
    }
}
#endif
