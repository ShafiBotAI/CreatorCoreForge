import Foundation

/// Combines signals from multiple timeframes using simple averaging.
public struct SignalFusionEngine {
    public init() {}

    public func fuse(_ signals: [Double]) -> Double {
        guard !signals.isEmpty else { return 0 }
        return signals.reduce(0, +) / Double(signals.count)
    }
}
