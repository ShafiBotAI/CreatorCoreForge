import Foundation

/// Generates a simple DF score heatmap across campaigns.
public struct DFScoreHeatmap {
    public init() {}

    public func heatmap(scores: [[Double]]) -> [Double] {
        guard !scores.isEmpty else { return [] }
        var result = Array(repeating: 0.0, count: scores[0].count)
        for row in scores { for (i, v) in row.enumerated() { result[i] += v } }
        return result.map { $0 / Double(scores.count) }
    }
}
