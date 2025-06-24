#if canImport(Combine)
import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif
import Combine

/// Engine that maps text cues to emotion profiles and adjusts voice playback.
public final class AIEmotionEngine: ObservableObject {
    /// Shared instance.
    public static let shared = AIEmotionEngine()

    /// Text trigger associated with an emotion and intensity.
    public struct EmotionCue: Codable {
        public var textTrigger: String
        public var emotion: EmotionProfile
        public var intensity: Float // 0.0 – 1.0
    }

    /// Supported emotion profiles for playback.
    public enum EmotionProfile: String, Codable, CaseIterable {
        case neutral, happy, sad, tense, romantic, angry, fear, euphoric
    }

    /// Registered emotion cues.
    @Published public var emotionCues: [EmotionCue] = []

    /// Analyze a text string and return the matching emotion profile if found.
    public func analyze(text: String) -> EmotionProfile {
        let lowered = text.lowercased()
        for cue in emotionCues {
            let pattern = "\\b" + NSRegularExpression.escapedPattern(for: cue.textTrigger.lowercased()) + "\\b"
            if let _ = lowered.range(of: pattern, options: [.regularExpression]) {
                return cue.emotion
            }
        }
        return .neutral
    }

    #if canImport(AVFoundation)
    /// Apply emotion adjustments to the provided utterance.
    public func applyEmotion(to utterance: AVSpeechUtterance,
                             emotion: EmotionProfile,
                             intensity: Float) {
        switch emotion {
        case .happy:
            utterance.pitchMultiplier += 0.2 * intensity
            utterance.rate += 0.05 * intensity
        case .sad:
            utterance.pitchMultiplier -= 0.2 * intensity
            utterance.rate -= 0.05 * intensity
        case .tense:
            utterance.rate += 0.1 * intensity
        case .romantic:
            utterance.rate -= 0.1 * intensity
        case .angry:
            utterance.pitchMultiplier += 0.1 * intensity
            utterance.rate += 0.15 * intensity
        case .fear:
            utterance.rate += 0.2 * intensity
            utterance.volume -= 0.2 * intensity
        case .euphoric:
            utterance.pitchMultiplier += 0.3 * intensity
            utterance.rate += 0.2 * intensity
        case .neutral:
            break
        }
    }
    #endif

    /// Register a new emotion cue for analysis.
    public func registerCue(trigger: String,
                            emotion: EmotionProfile,
                            intensity: Float) {
        let cue = EmotionCue(textTrigger: trigger, emotion: emotion, intensity: intensity)
        emotionCues.append(cue)
    }

    /// Remove all registered emotion cues.
    public func clearCues() {
        emotionCues.removeAll()
    }
}
#else
import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Minimal implementation when Combine is unavailable.
public final class AIEmotionEngine {
    public static let shared = AIEmotionEngine()

    public struct EmotionCue: Codable {
        public var textTrigger: String
        public var emotion: EmotionProfile
        public var intensity: Float
    }

    public enum EmotionProfile: String, Codable, CaseIterable {
        case neutral, happy, sad, tense, romantic, angry, fear, euphoric
    }

    private(set) public var emotionCues: [EmotionCue] = []

    public func analyze(text: String) -> EmotionProfile {
        let lowered = text.lowercased()
        for cue in emotionCues {
            if lowered.contains(cue.textTrigger.lowercased()) {
                return cue.emotion
            }
        }
        return .neutral
    }

    #if canImport(AVFoundation)
    public func applyEmotion(to utterance: AVSpeechUtterance,
                             emotion: EmotionProfile,
                             intensity: Float) {
        switch emotion {
        case .happy:
            utterance.pitchMultiplier += 0.2 * intensity
            utterance.rate += 0.05 * intensity
        case .sad:
            utterance.pitchMultiplier -= 0.2 * intensity
            utterance.rate -= 0.05 * intensity
        case .tense:
            utterance.rate += 0.1 * intensity
        case .romantic:
            utterance.rate -= 0.1 * intensity
        case .angry:
            utterance.pitchMultiplier += 0.1 * intensity
            utterance.rate += 0.15 * intensity
        case .fear:
            utterance.rate += 0.2 * intensity
            utterance.volume -= 0.2 * intensity
        case .euphoric:
            utterance.pitchMultiplier += 0.3 * intensity
            utterance.rate += 0.2 * intensity
        case .neutral:
            break
        }
    }
    #endif

    public func registerCue(trigger: String,
                            emotion: EmotionProfile,
                            intensity: Float) {
        let cue = EmotionCue(textTrigger: trigger, emotion: emotion, intensity: intensity)
        emotionCues.append(cue)
    }

    public func clearCues() {
        emotionCues.removeAll()
    }
}
#endif
