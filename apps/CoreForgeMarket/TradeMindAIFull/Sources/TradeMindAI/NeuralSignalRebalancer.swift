import Foundation

/// Adjusts signal weights based on volatility.
public struct NeuralSignalRebalancer {
    public init() {}

    public func rebalance(signals: [Double], volatility: Double) -> [Double] {
        guard volatility > 0 else { return signals }
        let factor = min(volatility, 1)
        let mean = signals.reduce(0, +) / Double(signals.count)
        return signals.map { $0 * (1 - factor) + mean * factor }
    }
}
