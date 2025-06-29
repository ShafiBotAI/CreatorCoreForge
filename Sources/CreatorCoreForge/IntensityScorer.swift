import Foundation

/// Scores scene text for intensity based on punctuation density.
public struct IntensityScorer {
    public init() {}

    public func score(sceneText: String) -> Double {
        let exclamations = sceneText.filter { $0 == "!" }.count
        let words = sceneText.split(separator: " ").count
        guard words > 0 else { return 0 }
        return Double(exclamations) / Double(words)
    }

    public func pattern(for scenes: [String]) -> [Double] {
        scenes.map { score(sceneText: $0) }
    }
}
