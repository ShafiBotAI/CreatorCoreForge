import Foundation

/// Simple controller to sync voice tracks with generated subtitles.
public struct VoiceSyncController {
    public init() {}

    /// Generate subtitles for the given script to sync with an audio file.
    public func sync(audioURL: URL, script: String) -> [Subtitle] {
        // Placeholder: generate subtitles directly from the script.
        generateSubtitles(from: script)
    }
}
