import Foundation

public struct TrendShiftDetector {
    public init() {}

    public func detect(prices: [Double]) -> Bool {
        guard prices.count >= 3 else { return false }
        let shortMA = prices.suffix(3).reduce(0, +) / 3
        let longCount = min(prices.count, 5)
        let longMA = prices.suffix(longCount).reduce(0, +) / Double(longCount)
        return shortMA > longMA
    }
}
