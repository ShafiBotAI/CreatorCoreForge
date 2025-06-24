import XCTest
@testable import CreatorCoreForge

final class AdaptiveLearningEngineTests: XCTestCase {
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
