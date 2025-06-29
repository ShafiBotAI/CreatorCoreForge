import Foundation

/// Evaluates simple trading strategies on historical data.
public struct BacktestingEngine {
    public init() {}

    /// Calculates mean return of provided price series.
    public func score(prices: [Double]) -> Double {
        guard prices.count > 1 else { return 0 }
        let returns = zip(prices.dropFirst(), prices).map { $0 / $1 - 1 }
        return returns.reduce(0, +) / Double(returns.count)
    }
}
