#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Expanded audiobook player.
struct PlayerView: View {
    @Binding var isPresented: Bool
    var book: Book
    var chapter: Chapter
    @State private var speed: Double = 1.0

    var body: some View {
        VStack(spacing: 20) {
            Text(chapter.title)
                .font(.title)
            ScrollView {
                Text(chapter.text)
                    .padding()
            }
            PlaybackSpeedControlView(speed: $speed)
            Button("Close") { isPresented = false }
                .buttonStyle(.bordered)
        }
        .padding()
        .background(AppTheme.primaryGradient.opacity(0.1))
    }
}
#endif

