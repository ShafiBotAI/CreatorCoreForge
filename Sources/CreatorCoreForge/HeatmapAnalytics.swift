import Foundation

/// Records intensity metrics for audio scenes.
public final class HeatmapAnalytics {
    private var values: [Int: Double] = [:]
    public init() {}

    public func log(chapter: Int, intensity: Double) {
        values[chapter] = intensity
    }

    public func intensity(for chapter: Int) -> Double {
        values[chapter] ?? 0
    }
}
