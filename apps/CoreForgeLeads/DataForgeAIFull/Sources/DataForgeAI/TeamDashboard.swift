import Foundation

/// Tracks team performance and generates simple leaderboards.
public final class TeamDashboard {
    private var leadCounts: [String: Int] = [:]

    public init() {}

    /// Record a lead assignment for a team member.
    public func assignLead(to member: String) {
        leadCounts[member, default: 0] += 1
    }

    /// Returns members sorted by lead count.
    public func leaderboard() -> [String] {
        leadCounts.sorted { $0.value > $1.value }.map { $0.key }
    }
}
