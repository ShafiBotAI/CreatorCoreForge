import Foundation

/// Persists character facts and relationships per scene.
public final class StoryMemory {
    public struct SceneFacts: Codable {
        public var characters: [String]
        public var relationships: [String]
        public var tone: String
        public var arc: String
    }

    private var store: [UUID: SceneFacts] = [:]
    public var multiverseLinkID: UUID?

    public init() {}

    /// Save facts for a scene.
    public func saveFacts(for sceneID: UUID, facts: SceneFacts) {
        store[sceneID] = facts
    }

    /// Retrieve facts for a scene.
    public func facts(for sceneID: UUID) -> SceneFacts? {
        store[sceneID]
    }

    /// Link this memory store to a multiverse ID.
    public func linkMultiverse(id: UUID) {
        multiverseLinkID = id
    }

    /// Persist memory to disk.
    public func save(to url: URL) throws {
        let data = try JSONEncoder().encode(store)
        try data.write(to: url)
    }

    /// Load memory from disk.
    public func load(from url: URL) throws {
        let data = try Data(contentsOf: url)
        store = try JSONDecoder().decode([UUID: SceneFacts].self, from: data)
    }
}
