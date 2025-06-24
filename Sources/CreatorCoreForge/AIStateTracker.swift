import Foundation

/// Tracks user prompt history for adaptive offline learning across apps.
public final class AIStateTracker {
    public static let shared = AIStateTracker()

    private let key = "AIStateTrackerHistory"
    private var history: [String: Int]

    public init(userDefaults: UserDefaults = .standard) {
        if let saved = userDefaults.dictionary(forKey: key) as? [String: Int] {
            history = saved
        } else {
            history = [:]
        }
        self.userDefaults = userDefaults
    }

    private let userDefaults: UserDefaults

    /// Record a prompt usage to update learning state.
    public func record(prompt: String) {
        let lower = prompt.lowercased()
        history[lower, default: 0] += 1
        persist()
    }

    /// Returns the most frequent prompts recorded so far.
    public func topPrompts(limit: Int = 5) -> [String] {
        return history
            .sorted { $0.value > $1.value }
            .prefix(limit)
            .map { $0.key }
    }

    /// Clears all stored prompt history.
    public func reset() {
        history.removeAll()
        persist()
    }

    private func persist() {
        userDefaults.set(history, forKey: key)
    }
}
