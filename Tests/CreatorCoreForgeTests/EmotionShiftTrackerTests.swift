import XCTest
@testable import CreatorCoreForge

final class EmotionShiftTrackerTests: XCTestCase {
    func testShiftLogging() {
        let tracker = EmotionShiftTracker()
        tracker.log(emotion: "happy", intensity: 0.5)
        tracker.log(emotion: "sad", intensity: 0.8)
        XCTAssertEqual(tracker.shifts.count, 1)
        if let first = tracker.shifts.first {
            XCTAssertEqual(first.from, "happy")
            XCTAssertEqual(first.to, "sad")
            XCTAssertEqual(first.delta, 0.3, accuracy: 0.0001)
        }
    }

    func testReset() {
        let tracker = EmotionShiftTracker()
        tracker.log(emotion: "happy", intensity: 0.5)
        tracker.log(emotion: "neutral", intensity: 0.2)
        tracker.reset()
        XCTAssertTrue(tracker.shifts.isEmpty)
    }
}
