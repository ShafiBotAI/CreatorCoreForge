import XCTest
@testable import CreatorCoreForge

final class AIStateTrackerTests: XCTestCase {
    func testRecordAndTopPrompts() {
        let suite = UserDefaults(suiteName: "AIStateTrackerTests")!
        let tracker = AIStateTracker(userDefaults: suite)
        tracker.reset()
        tracker.record(prompt: "Hello")
        tracker.record(prompt: "world")
        tracker.record(prompt: "hello")
        let top = tracker.topPrompts(limit: 1)
        XCTAssertEqual(top.first, "hello")
    }
}
