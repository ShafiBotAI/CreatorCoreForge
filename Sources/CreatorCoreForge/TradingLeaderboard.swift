import Foundation

/// Tracks trading scores for teams.
public struct TradingLeaderboard {
    private var scores: [String: Int] = [:]
    public init() {}
    /// Record a score for a team member.
    public mutating func record(user: String, score: Int) {
        scores[user, default: 0] += score
    }
    /// Returns users ranked by score descending.
    public func rankings() -> [String] {
        scores.sorted { $0.value > $1.value }.map { $0.key }
    }
}
