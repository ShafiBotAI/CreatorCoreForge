import XCTest
@testable import CreatorCoreForge

final class VoiceReviewSystemTests: XCTestCase {
    func testAverageRating() {
        let system = VoiceReviewSystem()
        system.addReview(for: "Narrator", user: "u1", rating: 4, comment: "good")
        system.addReview(for: "Narrator", user: "u2", rating: 2, comment: "ok")
        XCTAssertEqual(system.averageRating(for: "Narrator"), 3.0, accuracy: 0.001)
        XCTAssertEqual(system.allReviews(for: "Narrator").count, 2)
    }
}
