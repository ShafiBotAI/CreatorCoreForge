import Foundation

/// Maps portfolio holdings into simple risk buckets.
public struct PortfolioDNAVisualizer {
    public init() {}

    public func riskBuckets(for positions: [String: Double]) -> [String: Int] {
        var buckets: [String: Int] = [:]
        for (_, weight) in positions {
            let bucket = weight > 0.2 ? "high" : "low"
            buckets[bucket, default: 0] += 1
        }
        return buckets
    }
}
