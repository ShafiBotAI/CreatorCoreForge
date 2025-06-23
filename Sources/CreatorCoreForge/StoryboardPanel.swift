import Foundation

/// Simple panel representing a list of scenes.
public struct StoryboardPanel {
    private(set) var scenes: [String] = []
    public init() {}

    public mutating func addScene(_ scene: String) {
        scenes.append(scene)
    }

    public mutating func moveScene(from index: Int, to newIndex: Int) {
        guard scenes.indices.contains(index), scenes.indices.contains(newIndex) else { return }
        let item = scenes.remove(at: index)
        scenes.insert(item, at: newIndex)
    }

    public func list() -> [String] {
        scenes
    }
}

