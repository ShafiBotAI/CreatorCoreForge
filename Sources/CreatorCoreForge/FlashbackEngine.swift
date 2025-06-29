import Foundation

/// Inserts flashback scenes into a timeline and retimes subsequent scenes.
public struct FlashbackEngine {
    public init() {}

    /// Inserts a flashback scene at the given index and shifts later timestamps
    /// by one unit.
    public mutating func insertFlashback(scene: SceneNode,
                                         at index: Int,
                                         timeline: inout [SceneNode]) {
        var flash = scene
        flash = SceneNode(text: "[Flashback] " + flash.text,
                          tone: flash.tone,
                          characters: flash.characters,
                          timestamp: flash.timestamp)
        if index <= timeline.count {
            timeline.insert(flash, at: index)
            for i in (index + 1)..<timeline.count {
                let node = timeline[i]
                timeline[i] = SceneNode(text: node.text,
                                         tone: node.tone,
                                         characters: node.characters,
                                         timestamp: node.timestamp + 1)
            }
        }
    }
}
