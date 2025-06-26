#if canImport(SwiftUI)
import SwiftUI

/// Simple interface to assign voices to characters.
struct VoiceCastView: View {
    @Environment(\.dismiss) private var dismiss
    let characters: [String]
    @State private var selections: [String: String] = [:]

    private let voices = VoiceConfig.voices

    var body: some View {
        NavigationView {
            Form {
                ForEach(characters, id: \.self) { name in
                    Picker(name, selection: Binding(
                        get: { selections[name] ?? CharacterVoiceMemory.shared.voiceForCharacter(name).id ?? voices.first?.id ?? "" },
                        set: { selections[name] = $0 }
                    )) {
                        ForEach(voices, id: \.id) { voice in
                            Text(voice.name).tag(voice.id)
                        }
                    }
                }
            }
            .navigationTitle("Voice Cast")
            .toolbar {
                Button("Done") {
                    for (char, id) in selections {
                        if let voice = voices.first(where: { $0.id == id }) {
                            CharacterVoiceMemory.shared.assignVoice(voice, to: char)
                        }
                    }
                    dismiss()
                }
            }
        }
    }
}
#endif
