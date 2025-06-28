#if canImport(SwiftUI)
import SwiftUI

/// Simple interface to assign voices to characters.
struct VoiceCastView: View {
    @Environment(\.dismiss) private var dismiss
    let characters: [String]
    let series: String
    @State private var selections: [String: String] = [:]
    @AppStorage("isNSFWUnlocked") private var isNSFWUnlocked = false

    private let voices = VoiceConfig.voices
    private let nsfwVoices: Set<String> = ["ultra", "aisynth"]

    var body: some View {
        NavigationView {
            Form {
                ForEach(characters, id: \.self) { name in
                    Picker(name, selection: Binding(
                        get: { selections[name] ?? CharacterVoiceMemory.shared.voiceForCharacter(name, in: series).id ?? voices.first?.id ?? "" },
                        set: { selections[name] = $0 }
                    )) {
                        ForEach(voices, id: \.id) { voice in
                            Text(voice.name)
                                .tag(voice.id)
                                .disabled(nsfwVoices.contains(voice.id) && !isNSFWUnlocked)
                        }
                    }
                }
            }
            .navigationTitle("Voice Cast")
            .toolbar {
                Button("Use Previous") {
                    let mem = CharacterVoiceMemory.shared.assignments(for: series)
                    for (char, id) in mem { selections[char] = id }
                }
                Button("Done") {
                    for (char, id) in selections {
                        if let voice = voices.first(where: { $0.id == id }) {
                            CharacterVoiceMemory.shared.assignVoice(voice, to: char, in: series)
                        }
                    }
                    dismiss()
                }
            }
        }
        .onAppear {
            let mem = CharacterVoiceMemory.shared.assignments(for: series)
            for (char, id) in mem { selections[char] = id }
        }
    }
}
#endif
