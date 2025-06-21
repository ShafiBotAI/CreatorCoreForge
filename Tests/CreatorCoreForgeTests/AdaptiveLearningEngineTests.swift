import XCTest
@testable import CreatorCoreForge

final class AdaptiveLearningEngineTests: XCTestCase {
    func testNextTopic() {
        let engine = AdaptiveLearningEngine()
        engine.record(topic: "Math", score: 8)
        engine.record(topic: "Science", score: 5)
        XCTAssertEqual(engine.nextTopic(), "Science")
    }
}
