import Foundation

public struct BeatMatcher {
    public init() {}

    /// Suggest transitions between two sections based on tempo
    public func suggestTransition(from bpm1: Int, to bpm2: Int) -> String {
        if abs(bpm1 - bpm2) < 5 {
            return "Direct mix"
        } else if bpm1 < bpm2 {
            return "Gradual speed up"
        } else {
            return "Slow down into break"
        }
    }

    /// Recommend an advanced mix technique based on tempo and mood
    public func advancedMixRecommendation(bpm: Int, mood: String) -> String {
        let moodLower = mood.lowercased()
        if bpm > 130 && moodLower.contains("party") {
            return "High-energy drop"
        } else if bpm < 90 {
            return "Ambient fade"
        } else {
            return "Standard transition"
        }
    }
}
