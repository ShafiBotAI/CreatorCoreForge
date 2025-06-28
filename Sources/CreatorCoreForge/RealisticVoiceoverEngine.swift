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
    ///   - depth: Override for voice resonance.
    ///   - scope: Override for voice pitch range.
    ///   - completion: Called with synthesized audio data.
    public func speak(_ segment: Segment,
                      emotion: String? = nil,
                      depth: Double? = nil,
                      scope: Double? = nil,
                      completion: @escaping (Result<Data, Error>) -> Void) {
        var text = segment.text
        if let emotion = emotion {
            emotionAdapter.updateEmotion(emotion)
            text = emotionAdapter.adapt(text)
        }
        var profile = segment.voice ?? VoiceProfile(name: "Default")
        if let d = depth { profile.depth = d }
        if let s = scope { profile.scope = s }
        if let emotion = emotion { profile.emotion = emotion }
        voiceAI.synthesize(text: text, with: profile) { result in
            completion(result)
        }
    }
}
