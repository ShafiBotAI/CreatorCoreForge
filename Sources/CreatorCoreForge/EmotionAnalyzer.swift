import Foundation

/// Lightweight tone recommendation engine based on keywords.
public final class EmotionAnalyzer {
    public init() {}

    /// Represents a detected emotion with rendering suggestions.
    public struct EmotionProfile {
        public let emotion: String
        public let intensity: Float
        public let pitch: Float
        public let speed: Float
        public let volume: Float

        public init(emotion: String,
                    intensity: Float,
                    pitch: Float = 1.0,
                    speed: Float = 1.0,
                    volume: Float = 1.0) {
            self.emotion = emotion
            self.intensity = intensity
            self.pitch = pitch
            self.speed = speed
            self.volume = volume
        }
    }

    /// Analyze text and suggest a narration tone.
    public func recommendTone(for text: String) -> String {
        let lowered = text.lowercased()
        if lowered.contains("yeah right") || lowered.contains("as if") || lowered.contains("/s") {
            return "sarcastic"
        } else if lowered.contains("excited") || lowered.contains("amazing") {
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

        if lowered.contains("yeah right") || lowered.contains("as if") || lowered.contains("/s") {
            emotion = "sarcastic"
            intensity = 0.4
        } else if lowered.contains("excited") || lowered.contains("amazing") {
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

    /// Return a detailed profile including pitch, speed, and volume hints.
    public func detailedEmotion(for sentence: String) -> EmotionProfile {
        let base = analyzeEmotion(from: sentence)
        let emotion = classify(sentence: sentence)
        var pitch: Float = 1.0
        var speed: Float = 1.0
        var volume: Float = 1.0

        switch emotion {
        case "excited":
            pitch = 1.2; speed = 1.1; volume = 1.1
        case "sad":
            pitch = 0.9; speed = 0.9; volume = 0.8
        case "angry":
            pitch = 1.3; speed = 1.2; volume = 1.2
        case "curious":
            pitch = 1.1
        case "hesitant":
            speed = 0.95; pitch = 0.95
        case "sarcastic":
            speed = 1.05; pitch = 0.95
        default:
            break
        }

        return EmotionProfile(emotion: emotion,
                              intensity: base.intensity,
                              pitch: pitch,
                              speed: speed,
                              volume: volume)
    }

    /// Classify the overall emotion of a sentence.
    /// Very naive implementation using punctuation and keywords.
    public func classify(sentence: String) -> String {
        let lowered = sentence.lowercased()
        if lowered.contains("yeah right") || lowered.contains("as if") || lowered.contains("/s") {
            return "sarcastic"
        }
        if lowered.contains("sad") { return "sad" }
        if lowered.contains("wow") || lowered.contains("!") { return "excited" }
        if lowered.contains("?") { return "curious" }
        if lowered.contains("...") || lowered.contains("-") { return "hesitant" }
        return "neutral"
    }
}
