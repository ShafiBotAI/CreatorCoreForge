import Foundation

/// Allows fetching the latest market price for a symbol.
public protocol MarketPriceFetching {
    func fetchLatestPrice(symbol: String, completion: @escaping (Result<Double, Error>) -> Void)
}

extension ExchangeSyncManager: MarketPriceFetching {}

/// Fetches prices for multiple symbols and computes simple smart money indicators.
public final class MultiMarketScanner {
    private let syncManager: MarketPriceFetching

    public init(syncManager: MarketPriceFetching = ExchangeSyncManager()) {
        self.syncManager = syncManager
    }

    public func fetchPrices(symbols: [String], completion: @escaping ([String: Double]) -> Void) {
        let group = DispatchGroup()
        var results: [String: Double] = [:]
        for symbol in symbols {
            group.enter()
            syncManager.fetchLatestPrice(symbol: symbol) { result in
                if case .success(let price) = result {
                    results[symbol] = price
                }
                group.leave()
            }
        }
        group.notify(queue: .main) { completion(results) }
    }

    /// Simple heuristic that returns a normalized score based on price volatility.
    /// Higher variance relative to the average price yields a score closer to 1.
    public func smartMoneyScore(prices: [Double]) -> Double {
        guard prices.count > 1 else { return 0 }
        let avg = prices.reduce(0, +) / Double(prices.count)
        guard avg > 0 else { return 0 }
        let variance = prices.reduce(0) { $0 + pow($1 - avg, 2) } / Double(prices.count)
        let stdDev = sqrt(variance)
        let normalized = min(stdDev / avg, 1)
        return normalized
    }
}

