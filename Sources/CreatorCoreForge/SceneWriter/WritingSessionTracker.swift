import Foundation

/// Logs writing activity per scene and suggests stale scenes.
public final class WritingSessionTracker {
    private var timeLog: [UUID: TimeInterval] = [:]
    private var edits: [UUID: Int] = [:]
    private var wordCount: [UUID: Int] = [:]
    private var lastActive: [UUID: Date] = [:]

    public init() {}

    /// Record time spent editing a scene.
    public func log(sceneID: UUID, seconds: TimeInterval) {
        timeLog[sceneID, default: 0] += seconds
        lastActive[sceneID] = Date()
    }

    /// Update the word count for a scene.
    public func updateWordCount(sceneID: UUID, words: Int) {
        wordCount[sceneID] = words
        lastActive[sceneID] = Date()
    }

    /// Increment edit count for a scene.
    public func markEdit(sceneID: UUID) {
        edits[sceneID, default: 0] += 1
        lastActive[sceneID] = Date()
    }

    /// Return scenes ranked by combined activity (time + edits).
    public func heatmap() -> [UUID] {
        return lastActive.keys.sorted { lhs, rhs in
            let lhsScore = (timeLog[lhs] ?? 0) + Double(edits[lhs] ?? 0)
            let rhsScore = (timeLog[rhs] ?? 0) + Double(edits[rhs] ?? 0)
            return lhsScore > rhsScore
        }
    }

    /// Suggest scenes not modified recently or with zero words.
    public func staleScenes(threshold: TimeInterval = 60 * 60 * 24) -> [UUID] {
        let cutoff = Date().addingTimeInterval(-threshold)
        return lastActive.filter { ($0.value < cutoff) || (wordCount[$0.key] ?? 0) == 0 }
            .map { $0.key }
    }
}
