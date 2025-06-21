import XCTest
@testable import CreatorCoreForge

final class AdaptiveLearningEngineTests: XCTestCase {
    func testRecordAndCount() {
        let engine = AdaptiveLearningEngine()
        engine.reset()
        engine.recordCompletion(for: "lesson1")
        engine.recordCompletion(for: "lesson1")
        XCTAssertEqual(engine.completionCount(for: "lesson1"), 2)
    }
}
