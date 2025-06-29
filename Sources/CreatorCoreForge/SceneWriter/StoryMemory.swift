import Foundation

/// Persists character facts and relationships per scene.
public final class StoryMemory {
    public struct SceneFacts: Codable {
        public var characters: [String]
        public var relationships: [String]
        public var tone: String
    }

    private var store: [UUID: SceneFacts] = [:]

    public init() {}

    /// Save facts for a scene.
    public func saveFacts(for sceneID: UUID, facts: SceneFacts) {
        store[sceneID] = facts
    }

    /// Retrieve facts for a scene.
    public func facts(for sceneID: UUID) -> SceneFacts? {
        store[sceneID]
    }
}
