import Foundation
import CreatorCoreForge

/// Wrapper around `VoiceMemoryManager` exposing simple helpers for the app.
final class CharacterVoiceMemory {
    static let shared = CharacterVoiceMemory()
    private let manager = VoiceMemoryManager.shared

    private init() {}

    func assignVoice(_ voice: Voice, to character: String, in series: String) {
        manager.assign(voiceID: voice.id, to: character, in: series)
    }

    func voiceForCharacter(_ character: String, in series: String) -> Voice {
        if let id = manager.voiceID(for: character, in: series),
           let voice = VoiceConfig.voices.first(where: { $0.id == id }) {
            return voice
        }
        return VoiceConfig.voices.first ?? Voice(id: "default", name: "Default")
    }

    func assignments(for series: String) -> [String: String] {
        manager.assignments(for: series)
    }

    func allAssignments() -> [String: [String: String]] {
        manager.allAssignments()
    }
}
