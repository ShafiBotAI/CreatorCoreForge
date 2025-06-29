import Foundation

public struct EntryExitAdvisor {
    public init() {}

    public func signal(prices: [Double]) -> String {
        guard prices.count >= 2 else { return "HOLD" }
        let latest = prices.last!
        let prev = prices[prices.count - 2]
        if latest > prev { return "BUY" }
        if latest < prev { return "SELL" }
        return "HOLD"
    }
}
