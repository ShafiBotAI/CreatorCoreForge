import Foundation

public struct TrendAnalyzer {
    public init() {}

    /// Detect trending words in the given lyrics corpus
    public func trendingPhrases(from lyrics: [String], top: Int) -> [String] {
        var counts: [String: Int] = [:]
        for line in lyrics {
            line.lowercased().split(whereSeparator: { !$0.isLetter }).forEach { word in
                let key = String(word)
                counts[key, default: 0] += 1
            }
        }
        let sorted = counts.filter { $0.key.count > 3 }.sorted { $0.value > $1.value }
        return Array(sorted.prefix(top)).map { $0.key }
    }
}
