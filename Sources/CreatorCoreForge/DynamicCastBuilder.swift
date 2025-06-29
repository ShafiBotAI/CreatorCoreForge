import Foundation

/// Dynamically assigns point-of-view characters to scenes.
public final class DynamicCastBuilder {
    public init() {}

    /// Generate a mapping of scene index to POV character.
    /// Characters rotate in order for each scene.
    public func assignPOVs(characters: [String], sceneCount: Int) -> [Int: String] {
        guard !characters.isEmpty, sceneCount > 0 else { return [:] }
        var mapping: [Int: String] = [:]
        for index in 0..<sceneCount {
            let character = characters[index % characters.count]
            mapping[index] = character
        }
        return mapping
    }
}
