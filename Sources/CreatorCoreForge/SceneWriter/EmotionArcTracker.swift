import Foundation

/// Tracks emotional flow across multiple scenes.
public final class EmotionArcTracker {
    private var order: [UUID] = []
    private var emotions: [UUID: String] = [:]
    private let arc: [String] = ["calm", "rising tension", "climax", "resolution"]

    public init() {}

    /// Tag a scene with its primary emotion.
    public func tag(sceneID: UUID, emotion: String) {
        if emotions[sceneID] == nil {
            order.append(sceneID)
        }
        emotions[sceneID] = emotion
    }

    /// Return the emotional sequence of tagged scenes in order of insertion.
    public func emotionalFlow() -> [String] {
        order.compactMap { emotions[$0] }
    }

    /// Recommend the next emotional beat based on a simple arc cycle.
    public func recommendNextEmotion() -> String {
        let current = order.last.flatMap { emotions[$0] } ?? "calm"
        if let index = arc.firstIndex(of: current), index + 1 < arc.count {
            return arc[index + 1]
        }
        return arc.first ?? "calm"
    }
}
