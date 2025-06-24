import XCTest
@testable import CreatorCoreForge

final class EmotionalArcTrackerTests: XCTestCase {
    func testLogEmotionCreatesArcPoint() {
        let tracker = EmotionalArcTracker.shared
        tracker.clearArcs()
        tracker.logEmotion(character: "Zara", emotion: "joy", intensity: 0.9)
        let arc = tracker.getArc(for: "Zara")
        XCTAssertEqual(arc.count, 1)
        XCTAssertEqual(arc.first?.emotion, "joy")
    }

    func testAverageIntensity() {
        let tracker = EmotionalArcTracker.shared
        tracker.clearArcs()
        tracker.logEmotion(character: "Zara", emotion: "sad", intensity: 0.2)
        tracker.logEmotion(character: "Zara", emotion: "sad", intensity: 0.6)
        let avg = tracker.averageEmotionIntensity(for: "Zara")
        XCTAssertEqual(avg, 0.4, accuracy: 0.001)
    }
}
