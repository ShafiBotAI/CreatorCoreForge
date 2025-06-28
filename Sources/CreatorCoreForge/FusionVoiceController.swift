import Foundation

public protocol TTSAudioRendering {
    func render(text: String, voiceID: String, completion: @escaping (Result<Data, Error>) -> Void)
}

extension ElevenLabsRenderer: TTSAudioRendering {}

/// Orchestrates voice synthesis by combining multiple engines together.
public final class FusionVoiceController {
    private let voiceAI = LocalVoiceAI()
    private let emotionEngine = AIEmotionEngine()
    private let cache = OfflineTTSCache()
    private let remoteRenderer: TTSAudioRendering?

    public init(remoteRenderer: TTSAudioRendering? = nil,
                apiKey: String? = ProcessInfo.processInfo.environment["ELEVEN_API_KEY"]) {
        if let renderer = remoteRenderer {
            self.remoteRenderer = renderer
        } else if let key = apiKey, !key.isEmpty {
            self.remoteRenderer = ElevenLabsRenderer(apiKey: key)
        } else {
            self.remoteRenderer = nil
        }
    }

    /// Synthesizes the given text with emotion analysis and caching.
    /// Attempts remote rendering first if available, falling back to local.
    public func speak(text: String,
                      using profile: VoiceProfile,
                      preferOnline: Bool = true,
                      completion: @escaping (Data?) -> Void) {
        if let cached = cache.data(for: text) {
            completion(cached)
            return
        }
        let emotion = emotionEngine.analyze(text: text)
        let shift = Self.shift(for: emotion)

        let localRender = {
            self.voiceAI.synthesize(text: text, with: profile, emotionShift: shift) { [weak self] result in
                guard let self = self else { completion(nil); return }
                if case .success(let data) = result {
                    self.cache.store(data, for: text)
                    completion(data)
                } else {
                    completion(nil)
                }
            }
        }

        if preferOnline, let renderer = remoteRenderer {
            renderer.render(text: text, voiceID: profile.id) { [weak self] result in
                guard let self = self else { completion(nil); return }
                switch result {
                case .success(let data):
                    self.cache.store(data, for: text)
                    completion(data)
                case .failure:
                    localRender()
                }
            }
        } else {
            localRender()
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
