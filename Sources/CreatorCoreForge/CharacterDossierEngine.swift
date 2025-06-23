import Foundation

/// Represents a snapshot of a character's known history and traits.
public struct CharacterDossier: Codable {
    public var name: String
    public var age: Int
    public var traits: [String: String]
    public var memoryTokens: [MemoryToken]
    public var toneTimeline: [ToneRecord]
}

/// Provides read-only access to a character's dossier for review/editing UIs.
public final class CharacterDossierEngine {
    private let profileManager: CharacterProfileManager
    private let memoryEngine: CharacterMemoryEngine

    public init(profileManager: CharacterProfileManager = .shared,
                memoryEngine: CharacterMemoryEngine = CharacterMemoryEngine()) {
        self.profileManager = profileManager
        self.memoryEngine = memoryEngine
    }

    /// Generate a dossier for the specified character.
    public func dossier(for character: String) -> CharacterDossier {
        let profile = profileManager.profile(for: character) ?? CharacterProfile(name: character)
        let traits = memoryEngine.traits(for: character)
        return CharacterDossier(name: character,
                                age: profile.age,
                                traits: traits,
                                memoryTokens: profile.tokens,
                                toneTimeline: profile.toneTimeline)
    }
}
