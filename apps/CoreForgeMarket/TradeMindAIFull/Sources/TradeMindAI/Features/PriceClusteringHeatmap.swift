import Foundation

/// Creates a simple histogram of price levels for visualization.
public struct PriceClusteringHeatmap {
    public init() {}

    public func cluster(prices: [Double], bucketSize: Double) -> [Double: Int] {
        guard bucketSize > 0 else { return [:] }
        var histogram: [Double: Int] = [:]
        for price in prices {
            let bucket = (price / bucketSize).rounded() * bucketSize
            histogram[bucket, default: 0] += 1
        }
        return histogram
    }
}
