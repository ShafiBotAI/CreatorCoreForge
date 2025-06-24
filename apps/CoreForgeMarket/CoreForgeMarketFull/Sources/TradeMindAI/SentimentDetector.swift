import Foundation

/// Very basic sentiment detector using keyword heuristics.
public struct SentimentDetector {
    private let bullishWords = ["bull", "optimistic", "rally"]
    private let bearishWords = ["bear", "panic", "selloff"]

    public init() {}

    public func sentimentScore(for text: String) -> Double {
        let lower = text.lowercased()
        var score = 0.0
        for word in bullishWords { if lower.contains(word) { score += 1 } }
        for word in bearishWords { if lower.contains(word) { score -= 1 } }
        return score
    }
}
