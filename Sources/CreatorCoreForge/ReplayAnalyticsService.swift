import Foundation

/// Wraps `ReplayAnalytics` for simple service usage.
public final class ReplayAnalyticsService {
    private let analytics = ReplayAnalytics()
    public init() {}

    public func recordReplay(for line: String) {
        analytics.recordReplay(for: line)
    }

    public func stats(for line: String) -> ReplayAnalytics.Stats {
        analytics.stats(for: line)
    }

    public func reset() {
        analytics.reset()
    }
}
