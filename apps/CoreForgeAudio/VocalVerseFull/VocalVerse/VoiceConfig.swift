import Foundation

struct Voice {
    let id: String
    let name: String
}

struct VoiceConfig {
    private(set) static var voices: [Voice] = [
        Voice(id: "default", name: "Default"),
        Voice(id: "new", name: "NewVoice"),
        Voice(id: "celebrity", name: "Celebrity"),
        Voice(id: "narrator", name: "Narrator"),
        Voice(id: "storyteller", name: "Storyteller"),
        Voice(id: "assistant", name: "Assistant"),
        Voice(id: "morgan", name: "Morgan"),
        Voice(id: "emma", name: "Emma"),
        Voice(id: "athena", name: "Athena"),
        Voice(id: "zeus", name: "Zeus"),
        Voice(id: "ultra", name: "UltraAI"),
        Voice(id: "aisynth", name: "AiSynth"),
        Voice(id: "hermes", name: "Hermes")
    ]

    /// Cached list of voice display names for UI components.
    static var voiceNames: [String] {
        voices.map { $0.name }
    }

    static func addVoice(id: String, name: String) {
        guard !voices.contains(where: { $0.id == id }) else { return }
        voices.append(Voice(id: id, name: name))
    }
}

