import Foundation

/// Handles voice sample uploads and retrieval using `VoiceCloneTrainer` and `VoiceMemoryManager`.
public final class VoiceManager {
    private let trainer = VoiceCloneTrainer()
    private let memory = VoiceMemoryManager.shared

    public init() {}

    /// Upload and clone a voice sample for a character.
    public func uploadSample(character: String, sample: Data, completion: @escaping (VoiceProfile) -> Void) {
        trainer.train(from: sample, name: character) { profile in
            self.memory.assign(voiceID: profile.id, to: character, in: "global")
            completion(profile)
        }
    }

    /// Retrieve a stored voice profile for the given character.
    public func voiceProfile(for character: String) -> VoiceProfile? {
        guard let id = memory.voiceID(for: character, in: "global") else { return nil }
        return VoiceProfile(id: id, name: character)
    }
}
