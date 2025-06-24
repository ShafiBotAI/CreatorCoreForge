import Foundation

/// Generates emotion heatmaps for individual scenes.
public final class SceneHeatmapManager {
    private var maps: [String: EmotionHeatmap] = [:]
    public init() {}

    /// Log text for a particular scene.
    public func log(_ text: String, sceneID: String) {
        let map = maps[sceneID] ?? EmotionHeatmap()
        map.log(text)
        maps[sceneID] = map
    }

    /// Retrieve the latest normalized heatmap for a scene.
    public func heatmap(for sceneID: String, window: Int = 10) -> [Double] {
        maps[sceneID]?.generateHeatmap(window: window) ?? []
    }
}
