import Foundation

/// Generates voiceover audio with emotion-aware text adaptation.
public final class RealisticVoiceoverEngine {
    private let voiceAI: LocalVoiceAI
    private let emotionAdapter: RealTimeEmotionAdapter

    public init(voiceAI: LocalVoiceAI = LocalVoiceAI(),
                emotionAdapter: RealTimeEmotionAdapter = RealTimeEmotionAdapter()) {
        self.voiceAI = voiceAI
        self.emotionAdapter = emotionAdapter
    }

    /// Synthesize audio for a segment using the provided voice profile.
    /// - Parameters:
    ///   - segment: Text segment to speak.
    ///   - emotion: Optional emotion override.
    ///   - completion: Called with synthesized audio data.
    public func speak(_ segment: Segment,
                      emotion: String? = nil,
                      completion: @escaping (Result<Data, Error>) -> Void) {
        var text = segment.text
        if let emotion = emotion {
            emotionAdapter.updateEmotion(emotion)
            text = emotionAdapter.adapt(text)
        }
        let profile = segment.voice ?? VoiceProfile(name: "Default")
        voiceAI.synthesize(text: text, with: profile) { result in
            completion(result)
        }
    }
}
