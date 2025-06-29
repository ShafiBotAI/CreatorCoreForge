import Foundation

/// Represents a potential arbitrage opportunity between markets.
public struct ArbitrageOpportunity {
    public let symbol: String
    public let buyMarket: String
    public let sellMarket: String
    public let profit: Double
}

/// Scans market prices for arbitrage gaps.
public final class ArbitrageScanner {
    public init() {}

    /// - Parameter prices: Dictionary of symbol -> market -> price
    public func findOpportunities(prices: [String: [String: Double]]) -> [ArbitrageOpportunity] {
        var ops: [ArbitrageOpportunity] = []
        for (symbol, marketPrices) in prices {
            guard
                let minEntry = marketPrices.min(by: { $0.value < $1.value }),
                let maxEntry = marketPrices.max(by: { $0.value < $1.value }),
                maxEntry.value > minEntry.value
            else { continue }
            let profit = maxEntry.value - minEntry.value
            ops.append(ArbitrageOpportunity(symbol: symbol,
                                             buyMarket: minEntry.key,
                                             sellMarket: maxEntry.key,
                                             profit: profit))
        }
        return ops
    }
}
