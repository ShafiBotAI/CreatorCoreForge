import Foundation


/// Stores voice reviews and ratings from listeners.
public final class VoiceReviewSystem {
    public struct Review: Codable {
        public let user: String
        public let rating: Int
        public let comment: String

        public init(user: String, rating: Int, comment: String) {
            self.user = user
            self.rating = max(1, min(5, rating))
            self.comment = comment
        }
    }

    private var reviews: [String: [Review]] = [:]

    public init() {}

    /// Add a review for the given voice name.
    public func addReview(for name: String, user: String, rating: Int, comment: String) {
        let review = Review(user: user, rating: rating, comment: comment)
        reviews[name, default: []].append(review)
    }

    /// Average rating for a voice.
    public func averageRating(for name: String) -> Double {
        let values = reviews[name] ?? []
        guard !values.isEmpty else { return 0 }
        let sum = values.reduce(0) { $0 + $1.rating }
        return Double(sum) / Double(values.count)
    }

    /// Return all reviews for a voice.
    public func allReviews(for name: String) -> [Review] {
        reviews[name] ?? []
    }

    /// Remove all stored reviews.
    public func clear() { reviews.removeAll() }
}
