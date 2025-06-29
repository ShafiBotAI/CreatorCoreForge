import Foundation

/// Suggests optimal outreach delays based on engagement history.
public struct OutreachDelayOptimizer {
    public init() {}

    public func recommendedDelay(from history: [Date]) -> TimeInterval {
        guard history.count > 1 else { return 3600 }
        let sorted = history.sorted()
        var intervals: [TimeInterval] = []
        for i in 1..<sorted.count {
            intervals.append(sorted[i].timeIntervalSince(sorted[i-1]))
        }
        return intervals.reduce(0, +) / Double(intervals.count)
    }
}
