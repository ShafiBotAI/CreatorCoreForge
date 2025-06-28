#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Dropdown for selecting an active narration voice.
struct VoicePickerView: View {
    @Binding var voice: String
    @ObservedObject private var appFav = AppFavoriteVoiceService.shared
    private let voices = VoiceConfig.voiceNames

    var body: some View {
        Menu {
            if !appFavoriteNames.isEmpty {
                Text("App Favorites")
                ForEach(appFavoriteNames, id: \.self) { name in
                    Button(name) { select(name) }
                }
                Divider()
            }
            ForEach(voices, id: \.self) { name in
                Button(name) { select(name) }
            }
        } label: {
            HStack {
                Text(voice)
                Image(systemName: "chevron.down")
            }
        }
    }

    private var appFavoriteNames: [String] {
        appFav.dailyTopVoiceIDs.compactMap { id in
            VoiceConfig.voices.first { $0.id == id }?.name
        }
    }

    private func select(_ name: String) {
        voice = name
        if let id = VoiceConfig.voices.first(where: { $0.name == name })?.id {
            appFav.recordUsage(voiceID: id)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var voice = "Default"
        var body: some View {
            VoicePickerView(voice: $voice)
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
    return PreviewWrapper()
}
#endif
