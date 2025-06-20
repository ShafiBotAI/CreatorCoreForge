import Foundation

/// Generates a real-time emotion heatmap from logged intensities.
public final class EmotionHeatmap {
    private var intensities: [Double] = []
    private var labels: [String] = []

    public init() {}

    /// Log an emotion with the given intensity.
    public func log(emotion: String, intensity: Double) {
        labels.append(emotion)
        intensities.append(intensity)
    }

    /// Normalize recent intensities in the 0-1 range.
    /// - Parameter window: The number of latest entries to include.
    public func generateHeatmap(window: Int = 10) -> [Double] {
        let slice = intensities.suffix(window)
        guard let min = slice.min(), let max = slice.max(), max > min else {
            return Array(slice)
        }
        return slice.map { ($0 - min) / (max - min) }
    }
}
