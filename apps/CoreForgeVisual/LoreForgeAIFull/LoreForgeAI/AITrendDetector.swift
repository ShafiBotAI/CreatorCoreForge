import Foundation

/// Lightweight trend detector used by the Virality Engine.
/// Scores content based on trending keywords and simple frequency analysis.
final class AITrendDetector {
    private let trendingKeywords: Set<String>

    init(keywords: [String] = ["viral", "trending", "meme"]) {
        self.trendingKeywords = Set(keywords.map { $0.lowercased() })
    }

    /// Returns a basic virality score for a given piece of text.
    func score(for text: String) -> Double {
        let words = text.lowercased().components(separatedBy: CharacterSet.alphanumerics.inverted)
        guard !words.isEmpty else { return 0 }
        let matches = words.filter { trendingKeywords.contains($0) }
        return Double(matches.count) / Double(words.count)
    }

    /// Determines if the text should be boosted by the Virality Engine.
    func shouldBoostContent(_ text: String, threshold: Double = 0.1) -> Bool {
        return score(for: text) >= threshold
    }
}
