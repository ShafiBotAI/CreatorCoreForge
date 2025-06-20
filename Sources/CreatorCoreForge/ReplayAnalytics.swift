import Foundation

/// Tracks replay, skip, and loop statistics for audio lines.
public final class ReplayAnalytics {
    public struct Stats {
        public var replays: Int = 0
        public var skips: Int = 0
        public var loops: Int = 0
    }

    private var log: [String: Stats] = [:]

    public init() {}

    public func recordReplay(for line: String) {
        var stats = log[line, default: Stats()]
        stats.replays += 1
        log[line] = stats
    }

    public func recordSkip(for line: String) {
        var stats = log[line, default: Stats()]
        stats.skips += 1
        log[line] = stats
    }

    public func recordLoop(for line: String) {
        var stats = log[line, default: Stats()]
        stats.loops += 1
        log[line] = stats
    }

    public func stats(for line: String) -> Stats {
        return log[line] ?? Stats()
    }

    public func reset() {
        log.removeAll()
    }
}
