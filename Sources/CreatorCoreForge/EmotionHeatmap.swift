import Foundation

/// Generates a real-time emotion heatmap from text or logged intensity values.
public final class EmotionHeatmap {
    private let analyzer: EmotionAnalyzer
    private var intensities: [Double] = []
    private var labels: [String] = []

    public init(analyzer: EmotionAnalyzer = EmotionAnalyzer()) {
        self.analyzer = analyzer
    }

    /// Log a text snippet and capture its analyzed intensity.
    public func log(_ text: String) {
        let profile = analyzer.analyzeEmotion(from: text)
        let clamped = max(0, min(1, profile.intensity))
        labels.append(profile.emotion)
        intensities.append(Double(clamped))
    }

    /// Log an emotion with the given intensity manually.
    public func log(emotion: String, intensity: Double) {
        labels.append(emotion)
        intensities.append(intensity)
    }

    /// Normalize recent intensities in the 0-1 range.
    /// - Parameter window: The number of latest entries to include.
    public func generateHeatmap(window: Int = 10) -> [Double] {
        let slice = intensities.suffix(window)
        guard let minVal = slice.min(), let maxVal = slice.max(), maxVal > minVal else {
            return Array(slice)
        }
        return slice.map { ($0 - minVal) / (maxVal - minVal) }
    }
}
