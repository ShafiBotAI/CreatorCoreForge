import Foundation

/// Minimal audio playback simulation for tests and offline runs.
public final class AudioPlaybackEngine {
    private(set) var currentURL: URL?
    private(set) var isPlaying: Bool = false

    public init() {}

    public func load(url: URL) {
        currentURL = url
        print("Loaded audio: \(url.lastPathComponent)")
    }

    public func play() {
        guard currentURL != nil else { return }
        isPlaying = true
        print("▶️ Playing audio")
    }

    public func stop() {
        isPlaying = false
        print("⏹️ Stopped audio")
    }
}
