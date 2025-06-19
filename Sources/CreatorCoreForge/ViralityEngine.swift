import Foundation

/// Cross-app virality scorer used to highlight trending content.
public struct ViralityEngine {
    public let keywords: Set<String>

    public init(keywords: [String] = ["viral", "trending", "meme"]) {
        self.keywords = Set(keywords.map { $0.lowercased() })
    }

    /// Returns a score between 0 and 1 based on keyword frequency.
    public func score(for text: String) -> Double {
        let words = text
            .lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
        guard !words.isEmpty else { return 0 }
        let matches = words.filter { keywords.contains($0) }
        return Double(matches.count) / Double(words.count)
    }

    /// Whether content should be boosted based on the score threshold.
    public func shouldBoost(text: String, threshold: Double = 0.1) -> Bool {
        return score(for: text) >= threshold
    }
}
