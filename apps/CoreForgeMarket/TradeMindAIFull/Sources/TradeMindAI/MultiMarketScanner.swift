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

    /// Simple heuristic: average volume of given markets compared to price movement.
    /// Placeholder returning 0-1 score based on price variance.
    public func smartMoneyScore(prices: [Double]) -> Double {
        guard let max = prices.max(), let min = prices.min(), max > 0 else { return 0 }
        return (max - min) / max
    }
}

