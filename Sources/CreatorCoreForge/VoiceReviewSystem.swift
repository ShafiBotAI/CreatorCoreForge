import Foundation

/// Thin wrapper around `VoiceRatingSystem` for reviews.
public final class VoiceReviewSystem {
    private let ratings = VoiceRatingSystem()
    public init() {}

    public func addReview(for name: String, rating: Int) {
        ratings.addRating(for: name, rating: rating)
    }

    public func average(for name: String) -> Double {
        ratings.averageRating(for: name)
    }
}
