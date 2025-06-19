import Foundation

/// Persists character traits across multiple book series.
public final class CharacterMemoryEngine {
    private let storageKey = "CharacterMemoryEngineTraits"
    private let defaults: UserDefaults
    private var traits: [String: [String: String]]

    public init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
        if let saved = userDefaults.dictionary(forKey: storageKey) as? [String: [String: String]] {
            traits = saved
        } else {
            traits = [:]
        }
    }

    public func setTrait(_ trait: String, value: String, for character: String) {
        var map = traits[character.lowercased()] ?? [:]
        map[trait] = value
        traits[character.lowercased()] = map
        persist()
    }

    public func trait(_ trait: String, for character: String) -> String? {
        traits[character.lowercased()]?[trait]
    }

    public func clearAll() {
        traits.removeAll()
        persist()
    }

    private func persist() {
        defaults.set(traits, forKey: storageKey)
    }
}
