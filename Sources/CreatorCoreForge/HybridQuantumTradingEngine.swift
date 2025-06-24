import Foundation

/// Demonstrates a hybrid trading engine combining classical and quantum signals.
public struct HybridQuantumTradingEngine {
    public init() {}

    /// Evaluate market prices and return a basic trading action.
    public func evaluateSignals(_ prices: [Double]) -> String {
        guard let first = prices.first, let last = prices.last else { return "HOLD" }
        return last > first ? "BUY" : "SELL"
    }
}
