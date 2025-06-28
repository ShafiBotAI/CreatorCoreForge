import Foundation

/// Settings used when generating a free sample.
public struct SampleSettings {
    /// Voice profile to render the sample.
    public var voice: VoiceProfile
    /// Optional emotion adjustment passed to the voice engine.
    public var emotionShift: Double
    /// Sample rate for the generated audio.
    public var sampleRate: Int

    public init(voice: VoiceProfile,
                emotionShift: Double = 0.0,
                sampleRate: Int = 44_100) {
        self.voice = voice
        self.emotionShift = emotionShift
        self.sampleRate = sampleRate
    }
}

/// Generates a short audio preview from an eBook for all users.
public final class FreeSampleService {
    private let voiceEngine: LocalVoiceAI

    public init(voiceEngine: LocalVoiceAI = .init()) {
        self.voiceEngine = voiceEngine
    }

    /// Import the book and render the first five minutes using the selected voice.
    /// - Parameters:
    ///   - bookURL: Local path to the book file.
    ///   - settings: Voice and audio settings for the sample.
    /// - Returns: WAV data for playback.
    public func generateSample(from bookURL: URL,
                               settings: SampleSettings) async throws -> Data {
        let chapters = try await BookImporter.importBook(from: bookURL)
        guard let first = chapters.first else { return Data() }
        let words = first.text.split(whereSeparator: { $0.isWhitespace })
        let excerpt = words.prefix(750).joined(separator: " ")
        return try await withCheckedThrowingContinuation { cont in
            voiceEngine.synthesize(text: excerpt,
                                    with: settings.voice,
                                    emotionShift: settings.emotionShift,
                                    sampleRate: settings.sampleRate) { result in
                cont.resume(with: result)
            }
        }
    }
}
