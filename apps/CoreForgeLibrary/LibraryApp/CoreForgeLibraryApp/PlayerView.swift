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
        Group {
            if chapter.text.isEmpty {
                EmptyStateView(systemImage: "play.circle", message: "Select a chapter to play")
            } else {
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
            }
        }
        .padding()
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }
}
#endif

