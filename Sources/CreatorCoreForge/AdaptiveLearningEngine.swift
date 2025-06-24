import Foundation


/// Tracks user scores and suggests the next lesson with the lowest score.
/// Tracks lesson completion counts for adaptive learning across apps.
public final class AdaptiveLearningEngine {
    public static let shared = AdaptiveLearningEngine()
    private var progress: [String: Int] = [:]
    private var lastCompletion: [String: Date] = [:]
    private var topicScores: [String: Int] = [:]

    public init() {}

    /// Record that a lesson was completed.
    public func recordCompletion(for lessonID: String) {
        progress[lessonID, default: 0] += 1
        lastCompletion[lessonID] = Date()
    }

    /// Record a score for a learning topic.
    public func record(topic: String, score: Int) {
        topicScores[topic] = score
    }

    /// Return the topic with the lowest score, if any.
    public func nextTopic() -> String? {
        topicScores.min(by: { $0.value < $1.value })?.key
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
        topicScores.removeAll()

    }
}
