import Foundation

/// Represents an alternate visual outcome for a scene.
public struct VisualOutcome: Equatable {
    public let id: UUID
    public let sceneID: String
    public let description: String
    public let frames: [String]
    public let project: String

    public init(id: UUID = UUID(), sceneID: String, description: String, frames: [String], project: String) {
        self.id = id
        self.sceneID = sceneID
        self.description = description
        self.frames = frames
        self.project = project
    }
}

/// Stores alternate scene outcomes for multiverse rendering.
public final class VisualMultiverseManager {
    public static let shared = VisualMultiverseManager()

    private var outcomes: [UUID: VisualOutcome] = [:]

    public init() {}

    /// Add a new visual outcome for a scene.
    @discardableResult
    public func addOutcome(sceneID: String, description: String, frames: [String], project: String) -> VisualOutcome {
        let outcome = VisualOutcome(sceneID: sceneID, description: description, frames: frames, project: project)
        outcomes[outcome.id] = outcome
        return outcome
    }

    /// Return all outcomes for a scene within a project.
    public func outcomes(for sceneID: String, project: String) -> [VisualOutcome] {
        outcomes.values.filter { $0.sceneID == sceneID && $0.project == project }
    }

    /// Remove an outcome by its identifier.
    public func removeOutcome(_ id: UUID) {
        outcomes.removeValue(forKey: id)
    }

    /// Produce a map of scene IDs to number of alternate outcomes.
    public func multiverseMap(for project: String) -> [String: Int] {
        var map: [String: Int] = [:]
        for outcome in outcomes.values where outcome.project == project {
            map[outcome.sceneID, default: 0] += 1
        }
        return map
    }

    /// Return timeline variants sorted by description for a scene.
    public func timelineVariants(for sceneID: String, project: String) -> [VisualOutcome] {
        outcomes(for: sceneID, project: project).sorted { $0.description < $1.description }
    }

    /// Clear all stored outcomes.
    public func clearAll() {
        outcomes.removeAll()
    }
}
