import Foundation

/// Manages persistent character profiles including voice usage and memory tokens.
public final class CharacterProfileManager {
    public static let shared = CharacterProfileManager()
    private let key = "CharacterProfileManager.profiles"
    private let store: UserDefaults
    private var profiles: [String: CharacterProfile]

    public init(store: UserDefaults = .standard) {
        self.store = store
        if let data = store.data(forKey: key),
           let decoded = try? JSONDecoder().decode([String: CharacterProfile].self, from: data) {
            profiles = decoded
        } else {
            profiles = [:]
        }
    }

    public func profile(for name: String) -> CharacterProfile? {
        profiles[name.lowercased()]
    }

    public func save(_ profile: CharacterProfile) {
        profiles[profile.name.lowercased()] = profile
        persist()
    }

    public func addVoiceUsage(character: String, voiceID: String, bookID: String) {
        var profile = profiles[character.lowercased()] ?? CharacterProfile(name: character)
        profile.voiceUsage[bookID] = voiceID
        profiles[character.lowercased()] = profile
        persist()
    }

    public func recordTone(character: String, emotion: String, intensity: Float) {
        var profile = profiles[character.lowercased()] ?? CharacterProfile(name: character)
        profile.toneTimeline.append(ToneRecord(timestamp: Date(), emotion: emotion, intensity: intensity))
        profiles[character.lowercased()] = profile
        persist()
    }

    public func addMemoryToken(character: String, type: MemoryToken.TokenType, description: String) {
        var profile = profiles[character.lowercased()] ?? CharacterProfile(name: character)
        profile.tokens.append(MemoryToken(timestamp: Date(), type: type, description: description))
        profiles[character.lowercased()] = profile
        persist()
    }

    public func incrementAge(character: String, years: Int = 1) {
        var profile = profiles[character.lowercased()] ?? CharacterProfile(name: character)
        profile.age += years
        profiles[character.lowercased()] = profile
        persist()
    }

    public func lockMemory(character: String, locked: Bool) {
        var profile = profiles[character.lowercased()] ?? CharacterProfile(name: character)
        profile.memoryLocked = locked
        profiles[character.lowercased()] = profile
        persist()
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(profiles) {
            store.set(data, forKey: key)
        }
    }
}

public struct CharacterProfile: Codable {
    public var name: String
    public var age: Int = 0
    public var voiceUsage: [String: String] = [:] // bookID -> voiceID
    public var tokens: [MemoryToken] = []
    public var toneTimeline: [ToneRecord] = []
    public var memoryLocked: Bool = false

    public init(name: String) {
        self.name = name
    }
}

public struct MemoryToken: Codable {
    public enum TokenType: String, Codable { case milestone, trauma, growth }
    public var timestamp: Date
    public var type: TokenType
    public var description: String

    public init(timestamp: Date = Date(), type: TokenType, description: String) {
        self.timestamp = timestamp
        self.type = type
        self.description = description
    }
}

public struct ToneRecord: Codable {
    public var timestamp: Date
    public var emotion: String
    public var intensity: Float

    public init(timestamp: Date = Date(), emotion: String, intensity: Float) {
        self.timestamp = timestamp
        self.emotion = emotion
        self.intensity = intensity
    }
}
