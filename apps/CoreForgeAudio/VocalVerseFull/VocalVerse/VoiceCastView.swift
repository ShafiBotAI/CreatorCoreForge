#if canImport(SwiftUI)
import SwiftUI

/// Simple interface to assign voices to characters.
struct VoiceCastView: View {
    @Environment(\.dismiss) private var dismiss
    let characters: [String]
    let series: String
    @State private var selections: [String: String] = [:]

    @ObservedObject private var sub = SubscriptionManager.shared
    private var voices: [Voice] {
        if sub.tier == .enterprise || sub.tier == .authorPro {
            return VoiceConfig.voices
        } else {
            return VoiceConfig.voices.filter { voice in
                !["ultra", "aisynth", "hermes"].contains(voice.id)
            }
        }
    }

    var body: some View {
        NavigationView {
            Form {
                ForEach(characters, id: \.self) { name in
                    Picker(name, selection: Binding(
                        get: { selections[name] ?? CharacterVoiceMemory.shared.voiceForCharacter(name, in: series).id ?? voices.first?.id ?? "" },
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
