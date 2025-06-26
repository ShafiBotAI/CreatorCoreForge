import Foundation

/// Stores persistent voice assignments for characters across different book series.
final class CharacterVoiceMemory {
    static let shared = CharacterVoiceMemory()
    private var assignments: [String: String] = [:] // character -> voiceID
    private let userDefaultsKey = "CharacterVoiceAssignments"

    private init() {
        if let saved = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: String] {
            assignments = saved
        }
    }

    func assignVoice(_ voice: Voice, to character: String) {
        assignments[character.lowercased()] = voice.id
        persist()
    }

    /// Return the assigned voice for a given character. If no explicit
    /// assignment exists, fall back to the default voice so callers never
    /// receive `nil`.
    func voiceForCharacter(_ character: String) -> Voice {
        if let id = assignments[character.lowercased()],
           let voice = VoiceConfig.voices.first(where: { $0.id == id }) {
            return voice
        }
        return VoiceConfig.voices.first ?? Voice(id: "default", name: "Default")
    }

    func clearAll() {
        assignments.removeAll()
        persist()
    }

    private func persist() {
        UserDefaults.standard.set(assignments, forKey: userDefaultsKey)
    }

    /// Return all stored character to voice ID assignments.
    func allAssignments() -> [String: String] {
        assignments
    }
}
