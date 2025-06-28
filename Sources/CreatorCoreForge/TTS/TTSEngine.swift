import Foundation

/// High level TTS engine that combines humanizing layers.
public final class TTSEngine {
    private let analyzer = EmotionAnalyzer()
    private let breathing = BreathingLayer()
    private let prosody = ProsodyCurveManager()
    private let imperfection = AudioImperfectionFilter()
    private let conversation = ConversationalLayer()
    private let voiceAI = LocalVoiceAI()

    public init() {}

    /// Synthesize text using the provided profile. Resulting data is passed to the completion.
    public func synthesize(_ text: String, profile: VoiceProfile, completion: @escaping (Data?) -> Void) {
        let conv = conversation.apply(to: text)
        let sentences = conv.split(separator: ".").map { String($0).trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
        let withBreath = breathing.process(sentences: sentences).joined(separator: ". ")
        _ = sentences.map { analyzer.classify(sentence: $0) }
        _ = sentences.map { prosody.curveType(for: $0) }
        voiceAI.synthesize(text: withBreath, with: profile) { result in
            switch result {
            case .success(let data):
                completion(self.imperfection.apply(to: data))
            case .failure:
                completion(nil)
            }
        }
    }
}
