import Foundation

/// Simple AI-driven vocal processor.
public final class AIVocalProductionEngine {
    public init() {}

    /// Normalize a track so the maximum amplitude is 1.0.
    public func process(track: [Float]) -> [Float] {
        guard let maxVal = track.max(), maxVal != 0 else { return track }
        return track.map { $0 / maxVal }
    }
}
