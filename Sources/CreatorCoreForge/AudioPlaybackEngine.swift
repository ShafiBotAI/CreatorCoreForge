import Foundation

/// Minimal audio playback simulation for tests and offline runs.
public final class AudioPlaybackEngine {
    private(set) var currentURL: URL?
    private(set) var isPlaying: Bool = false
    private var position: Double = 0
    private var speed: Double = 1.0

    public init() {}

    public func load(url: URL) {
        currentURL = url
        position = 0
        print("Loaded audio: \(url.lastPathComponent)")
    }

    public func play() {
        guard currentURL != nil else { return }
        isPlaying = true
        print("▶️ Playing audio at \(position)s speed \(speed)x")
    }

    public func pause() {
        guard isPlaying else { return }
        isPlaying = false
        print("⏸️ Paused at \(position)s")
    }

    public func stop() {
        isPlaying = false
        position = 0
        print("⏹️ Stopped audio")
    }

    public func seek(to seconds: Double) {
        position = max(0, seconds)
        print("⏩ Seek to \(position)s")
    }

    public func setSpeed(_ rate: Double) {
        speed = max(0.5, min(rate, 5.0))
        print("⚡️ Speed set to \(speed)x")
    }

    public func currentSpeed() -> Double {
        speed
    }

    /// Skip forward by the specified number of seconds.
    public func skipForward(_ seconds: Double) {
        seek(to: position + seconds)
    }

    /// Skip backward by the specified number of seconds.
    public func skipBackward(_ seconds: Double) {
        seek(to: max(position - seconds, 0))
    }
}
