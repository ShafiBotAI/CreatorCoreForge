import Foundation

/// Generates a real-time sentiment heatmap from text input.
public final class SentimentHeatmap {
    private let detector: SentimentDetector
    private var scores: [Double] = []

    public init(detector: SentimentDetector = SentimentDetector()) {
        self.detector = detector
    }

    /// Log a new text string and record its sentiment score.
    public func log(_ text: String) {
        scores.append(detector.sentimentScore(for: text))
    }

    /// Normalize the most recent sentiment scores to the 0-1 range.
    /// - Parameter window: Number of latest scores to include.
    public func generateHeatmap(window: Int = 10) -> [Double] {
        let slice = scores.suffix(window)
        guard let min = slice.min(), let max = slice.max(), max > min else {
            return Array(slice)
        }
        return slice.map { ($0 - min) / (max - min) }
    }
}
