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
        Voice(id: "emma", name: "Emma")
    ]

    static func addVoice(id: String, name: String) {
        guard !voices.contains(where: { $0.id == id }) else { return }
        voices.append(Voice(id: id, name: name))
    }
}

// Register newly added voice
VoiceConfig.addVoice(id: "athena", name: "Athena")
VoiceConfig.addVoice(id: "zeus", name: "Zeus")
VoiceConfig.addVoice(id: "ultra", name: "UltraAI")
VoiceConfig.addVoice(id: "aisynth", name: "AiSynth")
VoiceConfig.addVoice(id: "hermes", name: "Hermes")
