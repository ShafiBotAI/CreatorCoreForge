import Foundation

/// Adjusts playback intensity based on heart rate feedback.
public final class HeartRateAdaptiveAudio {
    public init() {}

    public func adjust(intensity: Int) -> Double {
        let value = Double(intensity) / 100.0
        return max(0.5, min(2.0, value))
    }
}
