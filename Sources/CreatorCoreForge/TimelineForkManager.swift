import Foundation

/// Manages branching scene timelines for multiverse-style storytelling.
public final class TimelineForkManager {
    private var branches: [String: [SceneNode]] = [:]

    public init() {}

    /// Add or replace a branch with the provided scenes.
    public func add(branch: String, scenes: [SceneNode]) {
        branches[branch] = scenes
    }

    /// Retrieve scenes for a specific branch.
    public func scenes(for branch: String) -> [SceneNode] {
        branches[branch] ?? []
    }

    /// List all branch keys.
    public func allBranches() -> [String] {
        Array(branches.keys)
    }
}
