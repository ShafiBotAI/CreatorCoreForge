import Foundation

/// Lightweight tone recommendation engine based on keywords.
public final class EmotionAnalyzer {
    public init() {}

    /// Represents a detected emotion and its intensity.
    public struct EmotionProfile {
        public let emotion: String
        public let intensity: Float

        public init(emotion: String, intensity: Float) {
            self.emotion = emotion
            self.intensity = intensity
        }
    }

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

    /// Analyze text and return an emotion with a naive intensity score.
    public func analyzeEmotion(from text: String) -> EmotionProfile {
        let lowered = text.lowercased()
        var emotion = "neutral"
        var intensity: Float = 0.0

        if lowered.contains("excited") || lowered.contains("amazing") {
            emotion = "excited"
            intensity = 0.5
        } else if lowered.contains("sad") || lowered.contains("lost") {
            emotion = "sad"
            intensity = 0.5
        } else if lowered.contains("angry") || lowered.contains("furious") {
            emotion = "angry"
            intensity = 0.5
        }

        let exclamationCount = text.filter { $0 == "!" }.count
        if exclamationCount > 0 {
            intensity = min(1.0, intensity + Float(exclamationCount) * 0.1)
        }

        return EmotionProfile(emotion: emotion, intensity: intensity)
    }
}
