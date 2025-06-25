#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Lists available voices with the ability to mark favorites.
struct FavoritesView: View {
    @ObservedObject private var favorites = FavoriteVoiceService.shared
    private let voices = VoiceConfig.voices

    var body: some View {
        NavigationView {
            List(voices, id: \.id) { voice in
                HStack {
                    Text(voice.name)
                    Spacer()
                    Button(action: { favorites.toggle(voiceID: voice.id) }) {
                        Image(systemName: favorites.isFavorite(voice.id) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Favorite Voices")
        }
    }
}
#endif
