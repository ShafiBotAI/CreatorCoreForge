import XCTest
@testable import CreatorCoreForge

final class EmotionArcTrackerVisualizationTests: XCTestCase {
    func testVisualizeFlowJoinsEmotions() {
        let tracker = EmotionArcTracker()
        tracker.tag(sceneID: UUID(), emotion: "calm")
        tracker.tag(sceneID: UUID(), emotion: "climax")
        XCTAssertEqual(tracker.visualizeFlow(), "calm -> climax")
    }
}
