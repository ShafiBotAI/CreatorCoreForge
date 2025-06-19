import Foundation

/// Converts plain text into simple scene descriptions for storyboarding.
public struct SceneGenerator {
    public init() {}

    /// Splits the provided text into a list of scene outlines.
    /// Each sentence becomes its own scene up to `maxScenes`.
    public func generateScenes(from text: String, maxScenes: Int = 3) -> [String] {
        let sentences = text
            .split(separator: ".")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        return sentences.prefix(maxScenes).map { "Scene: " + $0 }
    }
}
