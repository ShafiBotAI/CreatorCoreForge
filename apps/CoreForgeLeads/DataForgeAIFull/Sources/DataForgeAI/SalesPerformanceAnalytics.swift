import Foundation

/// Calculates basic performance metrics for sales reps.
public struct SalesPerformanceAnalytics {
    public init() {}

    public func averageResponseTime(_ times: [TimeInterval]) -> TimeInterval {
        guard !times.isEmpty else { return 0 }
        return times.reduce(0, +) / Double(times.count)
    }
}
