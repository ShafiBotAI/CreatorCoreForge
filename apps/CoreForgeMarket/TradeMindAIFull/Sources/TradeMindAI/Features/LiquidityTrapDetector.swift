import Foundation

/// Detects potential liquidity traps using volume spikes.
public struct LiquidityTrapDetector {
    public init() {}

    public func isTrap(volumes: [Double], threshold: Double) -> Bool {
        guard volumes.count >= 2 else { return false }
        let latest = volumes.last!
        let avg = volumes.dropLast().reduce(0, +) / Double(volumes.count - 1)
        return latest > avg * (1 + threshold)
    }
}
