import Foundation

/// Tracks user scores and suggests the next lesson with the lowest score.
public final class AdaptiveLearningEngine {
    private var scores: [String: Int] = [:]
    public init() {}

    /// Record a score for a topic.
    public func record(topic: String, score: Int) {
        scores[topic] = score
    }

    /// Returns the topic needing the most improvement.
    public func nextTopic() -> String? {
        scores.min { $0.value < $1.value }?.key
    }
}
