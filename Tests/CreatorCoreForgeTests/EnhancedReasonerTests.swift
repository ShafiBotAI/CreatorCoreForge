import XCTest
@testable import CreatorCoreForge

final class EnhancedReasonerTests: XCTestCase {
    func testProgressScoreReflectsLoggedEvents() {
        let reasoner = EnhancedReasoner()
        reasoner.log("setup completed")
        reasoner.log("feature success")
        reasoner.log("compile error")
        XCTAssertGreaterThan(reasoner.progressScore(), 0.0)
        XCTAssertLessThan(reasoner.progressScore(), 1.0)
    }

    func testNextActionSuggestsDebugWhenFailuresDominate() {
        let reasoner = EnhancedReasoner()
        reasoner.log("error one")
        reasoner.log("error two")
        XCTAssertEqual(reasoner.nextAction(toward: "launch"), "Debug recent issues before continuing toward launch")
    }
}
