import Foundation

public final class SignalTracker {
    private var signals: [String] = []

    public init() {}

    /// Store a new market signal
    public func track(_ signal: String) {
        signals.append(signal)
    }

    /// Return the most recent signals up to the given limit
    public func recentSignals(limit: Int) -> [String] {
        Array(signals.suffix(limit))
    }

    /// Return most common signals up to the given limit
    public func topSignals(limit: Int) -> [String] {
        var counts: [String: Int] = [:]
        for s in signals { counts[s, default: 0] += 1 }
        let sorted = counts.sorted { $0.value > $1.value }
        return Array(sorted.prefix(limit)).map { $0.key }
    }

    /// Remove all stored signals
    public func clear() {
        signals.removeAll()
    }
}
