import Foundation

/// Generates a list of competitor follower targets for outreach.
public struct CompetitorTargeter {
    public init() {}

    /// Generate follower handles by mirroring the competitor's name.
    /// This lightweight implementation avoids network calls by
    /// producing deterministic sample handles. In a production
    /// environment this would query a social API or database.
    public func mirrorFollowers(of competitor: String) -> [String] {
        let base = competitor.replacingOccurrences(of: " ", with: "").lowercased()
        guard !base.isEmpty else { return [] }
        return (1...5).map { "\(base)_\($0)" }
    }
}
