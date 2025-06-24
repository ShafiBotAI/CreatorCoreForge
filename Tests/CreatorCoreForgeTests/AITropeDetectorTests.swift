import XCTest
@testable import CreatorCoreForge

final class AITropeDetectorTests: XCTestCase {
    func testDetectTropes() {
        let text = "It was a dark and stormy night when the chosen one arrived."
        let tropes = AITropeDetector.detect(in: text)
        XCTAssertEqual(Set(tropes), Set(["dark and stormy night", "chosen one"]))
    }

    func testBreakTropes() {
        let text = "Once upon a time there was an ancient prophecy."
        let result = AITropeDetector.breakTropes(in: text)
        XCTAssertFalse(result.lowercased().contains("once upon a time"))
        XCTAssertFalse(result.lowercased().contains("ancient prophecy"))
    }
}
