import Foundation

/// Swap visual elements based on cultural context.
public struct VisualContextAdapter {
    private let replacements: [String: [String: String]]
    public init(replacements: [String: [String: String]] = [:]) {
        self.replacements = replacements
    }

    public func adapt(scene: String, for culture: String) -> String {
        guard let map = replacements[culture] else { return scene }
        var result = scene
        for (key, value) in map { result = result.replacingOccurrences(of: key, with: value) }
        return result
    }
}
