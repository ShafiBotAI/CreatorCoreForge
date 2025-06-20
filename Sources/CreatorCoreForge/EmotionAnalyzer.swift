import Foundation

/// Lightweight tone recommendation engine based on keywords.
public final class EmotionAnalyzer {
    public init() {}

    /// Analyze text and suggest a narration tone.
    public func recommendTone(for text: String) -> String {
        let lowered = text.lowercased()
        if lowered.contains("excited") || lowered.contains("amazing") {
            return "excited"
        } else if lowered.contains("sad") || lowered.contains("lost") {
            return "somber"
        } else if lowered.contains("angry") || lowered.contains("furious") {
            return "angry"
        }
        return "calm"
    }
}
