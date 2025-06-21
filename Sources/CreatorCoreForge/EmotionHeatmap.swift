import Foundation

/// Generates a real-time emotion heatmap from text or logged intensity values.
public final class EmotionHeatmap {
    private let analyzer: EmotionAnalyzer
    private var intensities: [Double] = []
    private var labels: [String] = []

    public init(analyzer: EmotionAnalyzer = EmotionAnalyzer()) {
        self.analyzer = analyzer
    }

    /// Analyze a text snippet and log its emotion intensity.
    public func log(_ text: String) {
        let profile = analyzer.analyzeEmotion(from: text)
        log(emotion: profile.emotion, intensity: Double(profile.intensity))
    }

    /// Log an explicit emotion label and intensity.
    public func log(emotion: String, intensity: Double) {
        let clamped = max(0.0, min(1.0, intensity))
        labels.append(emotion)
        intensities.append(clamped)
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
