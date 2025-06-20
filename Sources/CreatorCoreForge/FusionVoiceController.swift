import Foundation

/// Orchestrates voice synthesis by combining multiple engines together.
public final class FusionVoiceController {
    private let voiceAI = LocalVoiceAI()
    private let emotionEngine = AIEmotionEngine()
    private let cache = OfflineTTSCache()

    public init() {}

    /// Synthesizes the given text with emotion analysis and caching.
    public func speak(text: String, using profile: VoiceProfile, completion: @escaping (Data?) -> Void) {
        if let cached = cache.data(for: text) {
            completion(cached)
            return
        }
        let emotion = emotionEngine.analyze(text: text)
        let shift = Self.shift(for: emotion)
        voiceAI.synthesize(text: text, with: profile, emotionShift: shift) { [weak self] result in
            guard let self = self else { completion(nil); return }
            if case .success(let data) = result {
                self.cache.store(data, for: text)
                completion(data)
            } else {
                completion(nil)
            }
        }
    }

    private static func shift(for emotion: AIEmotionEngine.EmotionProfile) -> Double {
        switch emotion {
        case .neutral: return 0
        case .happy: return 1
        case .sad: return -1
        case .tense: return 0.5
        case .romantic: return -0.5
        case .angry: return 1.5
        case .fear: return 0.7
        case .euphoric: return 2
        }
    }
}
