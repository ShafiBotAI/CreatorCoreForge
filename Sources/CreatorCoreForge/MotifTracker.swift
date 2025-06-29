import Foundation

/// Tracks recurring motifs or symbols across a text corpus.
public final class MotifTracker {
    private var counts: [String: Int] = [:]

    public init() {}

    public func register(_ motif: String) {
        counts[motif, default: 0] += 1
    }

    public func occurrences(of motif: String) -> Int {
        counts[motif, default: 0]
    }

    public func allMotifs() -> [String: Int] {
        counts
    }
}
