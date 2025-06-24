import Foundation

/// Splits a scene description into basic shot segments.
public final class SceneSegmenter {
    public init() {}

    /// Segment the scene string using simple period separation.
    public func segments(from scene: String) -> [String] {
        scene.split(separator: ".").map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
    }
}
