import Foundation

/// Mirrors trades from a leader with an adjustable risk multiplier.
public final class AutoCopyTrader {
    private let riskMultiplier: Double
    public init(riskMultiplier: Double = 1.0) {
        self.riskMultiplier = riskMultiplier
    }

    /// Returns the position size based on leader size and configured risk.
    public func mirroredSize(leaderSize: Double) -> Double {
        return leaderSize * riskMultiplier
    }
}
