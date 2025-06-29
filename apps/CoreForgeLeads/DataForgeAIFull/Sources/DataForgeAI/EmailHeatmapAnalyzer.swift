import Foundation

/// Analyzes open and click rates for outreach campaigns.
public struct EmailHeatmapAnalyzer {
    public struct Stats {
        public let opens: Int
        public let clicks: Int
    }

    public init() {}

    public func engagementRate(for stats: Stats) -> Double {
        guard stats.opens > 0 else { return 0 }
        return Double(stats.clicks) / Double(stats.opens)
    }
}
