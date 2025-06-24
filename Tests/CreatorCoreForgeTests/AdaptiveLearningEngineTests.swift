import XCTest
@testable import CreatorCoreForge

final class AdaptiveLearningEngineTests: XCTestCase {

    func testNextTopic() {
        let engine = AdaptiveLearningEngine()
        engine.record(topic: "Math", score: 8)
        engine.record(topic: "Science", score: 5)
        XCTAssertEqual(engine.nextTopic(), "Science")
    }

    func testRecordAndCount() {
        let engine = AdaptiveLearningEngine()
        engine.reset()
        engine.recordCompletion(for: "lesson1")
        let firstDate = engine.lastCompletionDate(for: "lesson1")
        sleep(1)
        engine.recordCompletion(for: "lesson1")
        let secondDate = engine.lastCompletionDate(for: "lesson1")
        XCTAssertEqual(engine.completionCount(for: "lesson1"), 2)
        XCTAssertNotNil(firstDate)
        XCTAssertNotNil(secondDate)
        XCTAssertLessThan(firstDate!, secondDate!)

    }
}
