import Foundation

/// Detects positions with losses exceeding a threshold.
public struct TaxLossHarvester {
    public init() {}

    public func harvestablePositions(prices: [Double], costBasis: [Double], threshold: Double) -> Int {
        guard prices.count == costBasis.count else { return 0 }
        var count = 0
        for (price, cost) in zip(prices, costBasis) {
            if cost - price >= threshold { count += 1 }
        }
        return count
    }
}
