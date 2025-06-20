import Foundation

/// Represents an audio sample used to train a custom voice.
public struct VoiceSample {
    /// Character the sample is associated with.
    public let characterName: String
    /// Local file path to the audio sample.
    public let audioFilePath: String
}

/// Basic engine that tracks uploaded samples and simulates training.
public final class VoiceTrainer {
    private var trainedVoices: [String: String] = [:]

    public init() {}

    /// Upload a voice sample for a character.
    /// - Parameters:
    ///   - character: Name of the character.
    ///   - filePath: Path to the sample audio file.
    public func uploadSample(for character: String, filePath: String) {
        print("Uploading voice sample for \(character)...")
        trainedVoices[character] = filePath
    }

    /// Train a voice using the previously uploaded sample.
    /// - Parameter character: Character to train.
    /// - Returns: `true` if training succeeded.
    @discardableResult
    public func trainVoice(for character: String) -> Bool {
        guard let samplePath = trainedVoices[character] else {
            print("No sample uploaded for \(character).")
            return false
        }
        print("Training voice for \(character) using sample at \(samplePath)...")
        Thread.sleep(forTimeInterval: 1.0)
        print("Training complete for \(character). Voice ready for use.")
        return true
    }

    /// Output a line using a trained voice if available.
    public func testVoice(character: String, testLine: String) {
        if trainedVoices[character] != nil {
            print("[\(character) - Custom Voice]: \(testLine)")
        } else {
            print("No custom voice found for \(character).")
        }
    }

    /// Print all currently trained voices.
    public func listTrainedVoices() {
        print("Trained Voices:")
        for (character, path) in trainedVoices {
            print("- \(character): \(path)")
        }
    }
}
