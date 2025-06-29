import Foundation

public struct TrailingStopAdvisor {
    public init() {}

    public func stopPrice(current: Double, volatility: Double) -> Double {
        let factor = min(max(volatility, 0), 1)
        return current * (1 - 0.05 * factor)
    }
}
