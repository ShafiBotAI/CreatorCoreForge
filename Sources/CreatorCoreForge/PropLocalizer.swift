import Foundation

/// Swap signage or props in scene text based on language.
public struct PropLocalizer {
    private let mappings: [String: [String: String]]
    public init(mappings: [String: [String: String]] = [:]) {
        self.mappings = mappings
    }

    public func localize(scene: String, to language: String) -> String {
        guard let map = mappings[language] else { return scene }
        var result = scene
        for (key, value) in map { result = result.replacingOccurrences(of: key, with: value) }
        return result
    }
}
