import Foundation

/// Provides pacing recommendations based on genre and word count.
public struct PacingAdvisor {
    public init() {}

    public func recommend(wordCount: Int, genre: String) -> String {
        let lower = genre.lowercased()
        let ideal = lower.contains("thriller") ? 150 : 250
        if wordCount > ideal {
            return "Consider shortening this scene for better pacing."
        } else if wordCount < ideal / 2 {
            return "Expand details to slow the pacing."
        } else {
            return "Pacing looks good."
        }
    }
}
