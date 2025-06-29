import Foundation

/// Generates a simple storyboard from a list of scenes.
public struct OneClickStoryboarder {
    public init() {}

    public func generate(from scenes: [String]) -> [String] {
        scenes.enumerated().map { index, scene in
            "Scene \(index + 1): \(scene)"
        }
    }
}
