import XCTest
@testable import CreatorCoreForge

final class EmotionArcTrackerNextTests: XCTestCase {
    func testRecommendNextEmotion() {
        let tracker = EmotionArcTracker()
        tracker.tag(sceneID: UUID(), emotion: "calm")
        XCTAssertEqual(tracker.recommendNextEmotion(), "rising tension")
    }
}
