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

        let profiles = sentences.map { analyzer.detailedEmotion(for: $0) }
        let annotated = zip(sentences, profiles).map { sentence, em in
            "<pitch=\(em.pitch)><speed=\(em.speed)><volume=\(em.volume)><curve=\(prosody.curveType(for: sentence))> \(sentence)"
        }

        let withBreath = breathing.process(sentences: annotated).joined(separator: ". ")

        let avgIntensity = profiles.map { $0.intensity }.reduce(0, +) / Float(max(profiles.count, 1))

        voiceAI.synthesize(text: withBreath, with: profile, emotionShift: Double(avgIntensity)) { result in
            switch result {
            case .success(let data):
                completion(self.imperfection.apply(to: data))
            case .failure:
                completion(nil)
            }
        }
    }
}
