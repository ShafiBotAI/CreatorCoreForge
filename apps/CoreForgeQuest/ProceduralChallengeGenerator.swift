import Foundation

/// Generates simple procedural challenges for demo purposes.
public struct ProceduralChallengeGenerator {
    private static let templates = ["Collect %d crystals", "Defeat %d enemies", "Explore %d rooms"]

    public static func generate() -> String {
        let choice = templates.randomElement() ?? "Complete the quest"
        let number = Int.random(in: 1...5)
        return String(format: choice, number)
    }
}
