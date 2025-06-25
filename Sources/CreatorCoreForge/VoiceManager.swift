import Foundation

/// Handles voice sample uploads and retrieval using `VoiceCloneTrainer` and `VoiceMemoryManager`.
public final class VoiceManager {
    private let trainer = VoiceCloneTrainer()
    private let memory = VoiceMemoryManager.shared
    private var bookMap: [String: [String: String]] = [:] // bookID -> character -> voiceID

    public init() {}

    /// Upload and clone a voice sample for a character.
    public func uploadSample(character: String, sample: Data, completion: @escaping (VoiceProfile) -> Void) {
        trainer.train(from: sample, name: character) { profile in
            self.assign(profile, to: character, in: "global")
            completion(profile)
        }
    }

    /// Assign a voice profile to a character for a specific book/series.
    public func assign(_ profile: VoiceProfile, to character: String, in book: String) {
        if bookMap[book] == nil { bookMap[book] = [:] }
        bookMap[book]?[character] = profile.id
        memory.assign(voiceID: profile.id, to: character, in: book)
    }

    /// Retrieve a stored voice profile for the given character and book.
    public func voiceProfile(for character: String, in book: String = "global") -> VoiceProfile? {
        let id = bookMap[book]?[character] ?? memory.voiceID(for: character, in: book)
        if let id { return VoiceProfile(id: id, name: character) }
        return nil
    }
}
