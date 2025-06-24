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

    /// Average intensity across all logged chapters.
    public func averageIntensity() -> Double {
        guard !values.isEmpty else { return 0 }
        return values.values.reduce(0, +) / Double(values.count)
    }

    /// Chapter index with the highest intensity value, if available.
    public func maxIntensityChapter() -> Int? {
        values.max { $0.value < $1.value }?.key
    }

    /// Clear all recorded values.
    public func reset() {
        values.removeAll()
    }
}
