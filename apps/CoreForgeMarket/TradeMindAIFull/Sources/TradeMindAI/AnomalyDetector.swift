import Foundation

/// Detects sudden market anomalies and triggers strategy pivots.
public final class AnomalyDetector {
    private let threshold: Double

    public init(threshold: Double = 0.1) {
        self.threshold = threshold
    }

    public func detectAnomaly(in values: [Double]) -> Bool {
        guard values.count >= 2, let last = values.last else { return false }
        let prev = values[values.count - 2]
        guard prev != 0 else { return false }
        let change = abs(last - prev) / abs(prev)
        return change > threshold
    }
}
