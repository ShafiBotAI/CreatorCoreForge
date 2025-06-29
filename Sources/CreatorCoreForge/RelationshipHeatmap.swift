import Foundation

public enum RelationshipType: String {
    case romantic, platonic, rival, mentor
}

/// Tracks interaction counts between character pairs by relationship type.
public final class RelationshipHeatmap {
    private var counts: [RelationshipType: [String: Int]] = [:]
    public init() {}

    /// Record an interaction between two characters.
    public func record(_ type: RelationshipType, between a: String, and b: String) {
        let key = a < b ? "\(a)-\(b)" : "\(b)-\(a)"
        var map = counts[type, default: [:]]
        map[key, default: 0] += 1
        counts[type] = map
    }

    /// Retrieve the strength value for a pair under a relationship type.
    public func strength(_ type: RelationshipType, pair: (String, String)) -> Int {
        let key = pair.0 < pair.1 ? "\(pair.0)-\(pair.1)" : "\(pair.1)-\(pair.0)"
        return counts[type]?[key] ?? 0
    }
}
