import Foundation

/// Simple engine that adjusts pitch based on event intensity.
public final class VoiceReactivity {
    public private(set) var lastPitch: Float = 1.0
    public init() {}

    /// Returns a pitch multiplier from 0.8 to 1.2 based on intensity 0.0-1.0.
    public func react(to intensity: Float) -> Float {
        let clamped = max(0.0, min(1.0, intensity))
        lastPitch = 1.0 + (clamped - 0.5) * 0.4
        return lastPitch
    }
}
