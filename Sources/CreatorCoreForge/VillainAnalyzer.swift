import Foundation

/// Analyzes villain descriptions to rate depth and flaw balance.
public struct VillainAnalysis {
    public let sympathyScore: Double
    public let flawScore: Double
}

public struct VillainAnalyzer {
    public init() {}

    /// Basic analysis using keyword heuristics.
    public func analyze(_ text: String) -> VillainAnalysis {
        let sympathyKeywords = ["tragic", "misunderstood", "sympathy"]
        let flawKeywords = ["flaw", "weakness", "hubris"]
        let sympathy = sympathyKeywords.reduce(0) { $0 + (text.lowercased().contains($1) ? 1 : 0) }
        let flaws = flawKeywords.reduce(0) { $0 + (text.lowercased().contains($1) ? 1 : 0) }
        return VillainAnalysis(sympathyScore: Double(sympathy) / Double(sympathyKeywords.count),
                               flawScore: Double(flaws) / Double(flawKeywords.count))
    }
}
