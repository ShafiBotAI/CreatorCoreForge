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
=======
/// Tracks lesson completion counts for adaptive learning across apps.
public final class AdaptiveLearningEngine {
    public static let shared = AdaptiveLearningEngine()
    private var progress: [String: Int] = [:]
    private var lastCompletion: [String: Date] = [:]

    public init() {}

    /// Record that a lesson was completed.
    public func recordCompletion(for lessonID: String) {
        progress[lessonID, default: 0] += 1
        lastCompletion[lessonID] = Date()
    }

    /// Returns how many times a lesson was completed.
    public func completionCount(for lessonID: String) -> Int {
        progress[lessonID] ?? 0
    }

    /// Returns the last completion date for a lesson, if available.
    public func lastCompletionDate(for lessonID: String) -> Date? {
        lastCompletion[lessonID]
    }

    /// Reset all stored progress.
    public func reset() {
        progress.removeAll()
        lastCompletion.removeAll()

    }
}
