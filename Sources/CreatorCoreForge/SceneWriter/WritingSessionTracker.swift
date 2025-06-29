import Foundation

/// Logs writing activity per scene and suggests stale scenes.
public final class WritingSessionTracker {
    private var timeLog: [UUID: TimeInterval] = [:]
    private var edits: [UUID: Int] = [:]
    private var lastActive: [UUID: Date] = [:]

    public init() {}

    /// Record time spent editing a scene.
    public func log(sceneID: UUID, seconds: TimeInterval) {
        timeLog[sceneID, default: 0] += seconds
        lastActive[sceneID] = Date()
    }

    /// Increment edit count for a scene.
    public func markEdit(sceneID: UUID) {
        edits[sceneID, default: 0] += 1
        lastActive[sceneID] = Date()
    }

    /// Return scenes sorted by most recently active.
    public func heatmap() -> [UUID] {
        lastActive.sorted { $0.value > $1.value }.map { $0.key }
    }

    /// Suggest scenes not modified recently.
    public func staleScenes(threshold: TimeInterval = 60 * 60 * 24) -> [UUID] {
        let cutoff = Date().addingTimeInterval(-threshold)
        return lastActive.filter { $0.value < cutoff }.map { $0.key }
    }
}
