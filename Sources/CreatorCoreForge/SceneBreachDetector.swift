import Foundation

/// Detects potential genre or world logic breaches within scenes.
public struct SceneBreachDetector {
    public init() {}

    /// Returns true if the scene contains content not allowed by the given rules.
    public func hasBreach(scene: String, bannedTerms: [String]) -> Bool {
        let lower = scene.lowercased()
        for term in bannedTerms.map({ $0.lowercased() }) {
            if lower.contains(term) { return true }
        }
        return false
    }
}
