import Foundation

/// Extracts key visual descriptions from text using simple regex patterns.
public struct VisualDescriptionExtractor {
    public init() {}

    /// Return sentences containing obvious visual adjectives.
    public func extract(from text: String) -> [String] {
        let patterns = ["\\b(red|blue|green|dark|light|bright|dim)\\b.*?\\b(\\w+)", "\\bglowing\\b", "\\bshadowy\\b"]
        let sentences = text.split(separator: ".")
        var results: [String] = []
        for raw in sentences {
            let sentence = raw.trimmingCharacters(in: .whitespacesAndNewlines)
            for pattern in patterns {
                if sentence.range(of: pattern, options: .regularExpression) != nil {
                    results.append(sentence)
                    break
                }
            }
        }
        return results
    }
}
