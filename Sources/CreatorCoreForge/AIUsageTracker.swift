import Foundation

/// Tracks usage of AI features and offers basic optimization hints.
public final class AIUsageTracker {
    private var usage: [String: Int] = [:]

    public init() {}

    /// Record a feature usage event.
    public func record(feature: String) {
        usage[feature, default: 0] += 1
    }

    /// Return usage counts for all features.
    public func report() -> [String: Int] {
        usage
    }

    /// Suggest a simple optimization pattern based on usage frequency.
    public func optimizationTips() -> [String] {
        usage.compactMap { key, value in
            if value > 3 {
                return "Consider creating shared helper for \(key)"
            }
            return "No suggestion"
        }
    }
}
