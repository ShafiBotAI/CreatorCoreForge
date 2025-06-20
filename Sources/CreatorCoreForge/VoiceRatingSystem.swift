import Foundation

/// Simple voice rating and review system for listeners.
public final class VoiceRatingSystem {
    private var ratings: [String: [Int]] = [:]

    public init() {}

    /// Record a rating (1-5) for a narrator or voice.
    public func addRating(for name: String, rating: Int) {
        ratings[name, default: []].append(max(1, min(5, rating)))
    }

    /// Average rating for the given voice name.
    public func averageRating(for name: String) -> Double {
        let values = ratings[name] ?? []
        guard !values.isEmpty else { return 0 }
        return Double(values.reduce(0, +)) / Double(values.count)
    }

    /// Clears all stored ratings.
    public func clearRatings() {
        ratings.removeAll()
    }
}
