import Foundation

/// Tracks viewer navigation across visual storylines.
public final class ViewerNavigationTracker {
    private var history: [String: [String]] = [:]

    public init() {}

    /// Record a scene visited by a viewer.
    public func record(viewerID: String, sceneID: String) {
        history[viewerID, default: []].append(sceneID)
    }

    /// Retrieve the navigation path for a viewer.
    public func path(for viewerID: String) -> [String] {
        history[viewerID] ?? []
    }
}
