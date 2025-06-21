import Foundation

/// Shared audio engine providing global controls across apps.
public final class UnifiedAudioEngine {
    public static let shared = UnifiedAudioEngine()

    private var volume: Double = 1.0
    private var muted: Bool = false

    private init() {}

    /// Set the global volume level between 0 and 1.
    public func setVolume(_ value: Double) {
        volume = min(max(value, 0), 1)
    }

    /// Retrieve the current volume level.
    public func currentVolume() -> Double {
        volume
    }

    /// Mute all audio.
    public func mute() { muted = true }

    /// Unmute audio.
    public func unmute() { muted = false }

    /// Indicates whether audio is muted.
    public var isMuted: Bool { muted }
}
