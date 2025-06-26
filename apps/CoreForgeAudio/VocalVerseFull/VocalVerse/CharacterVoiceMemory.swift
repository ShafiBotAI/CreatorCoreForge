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

    func voiceForCharacter(_ character: String) -> Voice? {
        guard let id = assignments[character.lowercased()] else { return nil }
        return VoiceConfig.voices.first { $0.id == id }
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
