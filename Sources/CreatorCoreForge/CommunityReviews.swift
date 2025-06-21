import Foundation

/// Stores simple community reviews for books or chapters.
public final class CommunityReviews {
    private var reviews: [String: [String]] = [:]
    public init() {}

    public func addReview(_ text: String, for item: String) {
        reviews[item, default: []].append(text)
    }

    public func allReviews(for item: String) -> [String] {
        reviews[item] ?? []
    }
}
