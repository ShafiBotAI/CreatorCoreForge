import Foundation

/// Provides a lightweight preview simulator for scene nodes.
public struct PreviewSandbox {
    public init() {}

    /// Pretend to preview scenes and return the target frames-per-second.
    public func preview(scenes: [SceneNode]) -> Double {
        // Demo implementation always returns 60 FPS.
        60.0
    }
}
