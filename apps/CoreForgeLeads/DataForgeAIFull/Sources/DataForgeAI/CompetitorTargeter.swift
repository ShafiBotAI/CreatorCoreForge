import Foundation

/// Generates a list of competitor follower targets for outreach.
public struct CompetitorTargeter {
    public init() {}

    public func mirrorFollowers(of competitor: String) -> [String] {
        // Simple deterministic follower names based on competitor identifier
        let baseNames = ["alice", "bob", "carol", "dave", "eve"]
        let seed = abs(competitor.hashValue % 100)
        return baseNames.map { "\(competitor)-\($0)-\(seed)" }
    }
}
