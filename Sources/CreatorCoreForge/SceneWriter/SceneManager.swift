import Foundation

/// Manages a collection of scenes with basic editing utilities.
public final class SceneManager {
    public private(set) var scenes: [SceneDraft]
    private var active: Set<UUID> = []
    private var alternates: [UUID: [SceneDraft]] = [:]
    public private(set) var pinnedSceneID: UUID?

    public init(scenes: [SceneDraft] = []) {
        self.scenes = scenes
        self.active = Set(scenes.map { $0.id })
    }

    /// Reorder a scene to a new index.
    public func reorder(sceneID: UUID, to index: Int) {
        guard let currentIndex = scenes.firstIndex(where: { $0.id == sceneID }),
              scenes.indices.contains(index) else { return }
        let scene = scenes.remove(at: currentIndex)
        scenes.insert(scene, at: index)
    }

    /// Toggle whether a scene is active.
    public func toggleActive(sceneID: UUID) {
        if active.contains(sceneID) {
            active.remove(sceneID)
        } else {
            active.insert(sceneID)
        }
    }

    /// Add an alternate version of a scene.
    public func addAlternateScene(for sceneID: UUID, draft: SceneDraft) {
        alternates[sceneID, default: []].append(draft)
    }

    /// Pin a scene as an anchor point.
    public func pinScene(id: UUID) {
        pinnedSceneID = id
    }

    /// Return only the active scenes in their current order.
    public func activeScenes() -> [SceneDraft] {
        scenes.filter { active.contains($0.id) }
    }

    /// Retrieve alternate drafts for a given scene.
    public func alternateScenes(for sceneID: UUID) -> [SceneDraft] {
        alternates[sceneID] ?? []
    }
}
