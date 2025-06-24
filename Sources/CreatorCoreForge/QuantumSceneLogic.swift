import Foundation

/// Provides a simple weighted collapse for branching scenes.
/// Paths with longer identifiers are considered more "stable" and
/// therefore have a higher chance of being selected.
public struct QuantumSceneLogic {
    public init() {}

    public func collapse(paths: [String]) -> String {
        guard !paths.isEmpty else { return "" }
        let weights = paths.map { Double($0.count) }
        let total = weights.reduce(0, +)
        let target = Double.random(in: 0..<total)
        var cumulative = 0.0
        for (index, weight) in weights.enumerated() {
            cumulative += weight
            if target < cumulative { return paths[index] }
        }
        return paths.last!
    }
}
