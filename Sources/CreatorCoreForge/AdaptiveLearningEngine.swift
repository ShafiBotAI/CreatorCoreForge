import Foundation

/// Tracks lesson completion counts for adaptive learning across apps.
public final class AdaptiveLearningEngine {
    public static let shared = AdaptiveLearningEngine()
    private var progress: [String: Int] = [:]

    public init() {}

    /// Record that a lesson was completed.
    public func recordCompletion(for lessonID: String) {
        progress[lessonID, default: 0] += 1
    }

    /// Returns how many times a lesson was completed.
    public func completionCount(for lessonID: String) -> Int {
        progress[lessonID] ?? 0
    }

    /// Reset all stored progress.
    public func reset() {
        progress.removeAll()
    }
}
