import XCTest
@testable import CreatorCoreForge

final class ViralityEngineGlobalTests: XCTestCase {
    func testBoost() {
        let engine = ViralityEngine(keywords: ["viral"])
        XCTAssertTrue(engine.shouldBoost(text: "This is a viral clip"))
        XCTAssertFalse(engine.shouldBoost(text: "nothing special"))
    }
}
