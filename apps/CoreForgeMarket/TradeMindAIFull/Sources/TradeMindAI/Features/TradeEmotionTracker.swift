import Foundation

/// Tracks trading emotions like FOMO and fear.
public final class TradeEmotionTracker {
    private var log: [String: Int] = [:]
    public init() {}

    public func record(_ emotion: String) {
        log[emotion, default: 0] += 1
    }

    public var summary: [String: Int] { log }
}
