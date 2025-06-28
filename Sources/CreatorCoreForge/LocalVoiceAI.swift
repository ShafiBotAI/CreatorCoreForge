import Foundation

/// Represents a lightweight local voice profile used for synthesis.
public struct VoiceProfile: Codable, Equatable {
    /// Unique identifier for the profile.
    public let id: String
    /// Display name of the voice.
    public var name: String
    /// Base emotion for synthesis (e.g. "neutral", "happy").
    public var emotion: String
    /// Depth multiplier for voice resonance.
    public var depth: Double
    /// Scope multiplier for voice pitch range.
    public var scope: Double

    public init(id: String = UUID().uuidString,
                name: String,
                emotion: String = "neutral",
                depth: Double = 1.0,
                scope: Double = 1.0) {
        self.id = id
        self.name = name
        self.emotion = emotion
        self.depth = depth
        self.scope = scope
    }
}

/// Offline-first voice engine that generates simple PCM audio data so apps can
/// run without external services. Audio quality is intentionally basic but it
/// allows tests to verify end-to-end flows.
public final class LocalVoiceAI {
    public init() {}

    /// Creates a new `VoiceProfile` from raw audio data.
    /// This mimics a cloning process locally by generating a new identifier.
    /// - Parameters:
    ///   - sample: Voice sample data.
    ///   - name: Desired display name for the voice.
    ///   - completion: Called with the created profile.
    public func cloneVoice(from sample: Data, name: String, completion: @escaping (VoiceProfile) -> Void) {
        DispatchQueue.global().async {
            let avg = sample.reduce(0) { $0 + Int($1) } / max(sample.count, 1)
            let emotion = avg > 200 ? "excited" : "neutral"
            completion(VoiceProfile(name: name, emotion: emotion))
        }
    }

    /// Synthesizes speech for the provided text using the given profile.
    /// - Parameters:
    ///   - text: Input text to speak.
    ///   - profile: Voice profile to use during synthesis.
    ///   - emotionShift: Optional adjustment to the base emotion.
    ///   - completion: Returns synthesized audio data (mocked).
    public func synthesize(text: String,
                           with profile: VoiceProfile,
                           emotionShift: Double = 0.0,
                           sampleRate: Int = 44100,
                           completion: @escaping (Result<Data, Error>) -> Void) {
        DispatchQueue.global().async {
            var samples: [Int16] = []
            for ch in text.utf8 {
                let baseFreq = 200.0 + Double(ch % 40) * 10.0
                let freq = baseFreq * profile.scope + emotionShift * 5.0
                samples += Self.sineWave(frequency: freq,
                                        duration: 0.05,
                                        sampleRate: sampleRate,
                                        amplitude: 30000 * profile.depth)
            }
            let data = Self.encodeWAV(samples: samples, sampleRate: sampleRate)
            completion(.success(data))
        }
    }

    private static func sineWave(frequency: Double,
                                 duration: Double,
                                 sampleRate: Int,
                                 amplitude: Double) -> [Int16] {
        let count = Int(Double(sampleRate) * duration)
        let amp = max(min(amplitude, 32_000), 0)
        return (0..<count).map { i in
            let t = Double(i) / Double(sampleRate)
            let value = sin(2.0 * .pi * frequency * t)
            return Int16(value * amp)
        }
    }

    private static func encodeWAV(samples: [Int16], sampleRate: Int) -> Data {
        var data = Data()
        let byteRate = sampleRate * 2
        let dataSize = samples.count * 2

        data.append("RIFF".data(using: .ascii)!)
        var chunkSize = UInt32(36 + dataSize)
        data.append(Data(bytes: &chunkSize, count: 4))
        data.append("WAVE".data(using: .ascii)!)

        data.append("fmt ".data(using: .ascii)!)
        var subChunk1Size: UInt32 = 16
        data.append(Data(bytes: &subChunk1Size, count: 4))
        var audioFormat: UInt16 = 1
        data.append(Data(bytes: &audioFormat, count: 2))
        var numChannels: UInt16 = 1
        data.append(Data(bytes: &numChannels, count: 2))
        var sampleRate32 = UInt32(sampleRate)
        data.append(Data(bytes: &sampleRate32, count: 4))
        var byteRate32 = UInt32(byteRate)
        data.append(Data(bytes: &byteRate32, count: 4))
        var blockAlign: UInt16 = 2
        data.append(Data(bytes: &blockAlign, count: 2))
        var bitsPerSample: UInt16 = 16
        data.append(Data(bytes: &bitsPerSample, count: 2))

        data.append("data".data(using: .ascii)!)
        var dataSize32 = UInt32(dataSize)
        data.append(Data(bytes: &dataSize32, count: 4))

        samples.forEach { sample in
            var s = sample
            data.append(Data(bytes: &s, count: 2))
        }
        return data
    }
}
