import Foundation

/// Simple AI-assisted document scanner that learns keyword usage.
public final class AdaptiveDocScanner {
    private var keywordCounts: [String: Int] = [:]

    public init() {}

    /// Scan text for the given keywords, updating internal counts.
    @discardableResult
    public func scan(text: String, keywords: [String]) -> [String] {
        let lower = text.lowercased()
        var found: [String] = []
        for key in keywords {
            if lower.contains(key.lowercased()) {
                keywordCounts[key, default: 0] += 1
                found.append(key)
            }
        }
        return found
    }

    /// Return keywords observed at least `minCount` times.
    public func learnedKeywords(minCount: Int = 1) -> [String] {
        keywordCounts.filter { $0.value >= minCount }.map { $0.key }
    }

    /// Reset all learned counts.
    public func reset() {
        keywordCounts.removeAll()
    }
}
