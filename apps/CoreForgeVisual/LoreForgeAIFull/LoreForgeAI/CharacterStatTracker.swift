import Foundation

/// Stores and updates RPG-style character statistics.
struct CharacterStats {
    var strength: Int
    var agility: Int
    var intellect: Int
}

final class CharacterStatTracker {
    private var stats: [String: CharacterStats] = [:]

    func setStats(for name: String, stats: CharacterStats) {
        self.stats[name.lowercased()] = stats
    }

    func updateStat(for name: String, keyPath: WritableKeyPath<CharacterStats, Int>, delta: Int) {
        guard var current = stats[name.lowercased()] else { return }
        current[keyPath: keyPath] += delta
        stats[name.lowercased()] = current
    }

    func statsForCharacter(_ name: String) -> CharacterStats? {
        stats[name.lowercased()]
    }
}
