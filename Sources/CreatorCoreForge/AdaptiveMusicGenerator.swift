import Foundation

/// Generates short background music loops adapted to a mood string.
/// The implementation writes a simple sine wave to a temporary WAV file so
/// that callers can preview mood-based audio without external assets.
public final class AdaptiveMusicGenerator {
    public init() {}

    /// Generate a WAV file representing the requested mood.
    /// - Parameter mood: descriptive term such as "calm" or "tense".
    /// - Returns: URL to the generated audio file or `nil` on failure.
    public func generate(mood: String) -> URL? {
        let sampleRate = 44_100
        let duration: Double = 1.0
        let frequency: Double

        switch mood.lowercased() {
        case "calm": frequency = 220
        case "tense": frequency = 880
        case "happy": frequency = 660
        default: frequency = 440
        }

        let frameCount = Int(duration * Double(sampleRate))
        var samples = [Int16](repeating: 0, count: frameCount)
        for i in 0..<frameCount {
            let t = Double(i) / Double(sampleRate)
            let value = Int16(sin(2 * .pi * frequency * t) * 32767 * 0.4)
            samples[i] = value
        }

        var data = Data()
        // Write minimal WAV header
        let byteCount = samples.count * MemoryLayout<Int16>.size
        data.append("RIFF".data(using: .ascii)!)
        data.append(UInt32(36 + byteCount).littleEndianData)
        data.append("WAVEfmt ".data(using: .ascii)!)
        data.append(UInt32(16).littleEndianData) // PCM chunk size
        data.append(UInt16(1).littleEndianData)  // format PCM
        data.append(UInt16(1).littleEndianData)  // mono
        data.append(UInt32(sampleRate).littleEndianData)
        data.append(UInt32(sampleRate * 2).littleEndianData) // byte rate
        data.append(UInt16(2).littleEndianData)  // block align
        data.append(UInt16(16).littleEndianData) // bits per sample
        data.append("data".data(using: .ascii)!)
        data.append(UInt32(byteCount).littleEndianData)

        // Append samples
        samples.withUnsafeBufferPointer { ptr in
            data.append(Data(buffer: ptr))
        }

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("wav")
        do {
            try data.write(to: url)
            return url
        } catch {
            // On failure write an empty placeholder file so callers get a valid URL
            let fallback = FileManager.default.temporaryDirectory
                .appendingPathComponent("fallback_\(UUID().uuidString)")
                .appendingPathExtension("wav")
            _ = FileManager.default.createFile(atPath: fallback.path, contents: Data(), attributes: nil)
            return fallback
        }
    }
}

private extension FixedWidthInteger {
    var littleEndianData: Data { withUnsafeBytes(of: self.littleEndian) { Data($0) } }
}
