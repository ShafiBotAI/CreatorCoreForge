import XCTest
@testable import VocalVision

final class BookToVideoCreditEngineTests: XCTestCase {
    func testCreditConsumptionAndAdditions() {
        let engine = BookToVideoCreditEngine(initialCredits: 1)
        XCTAssertTrue(engine.canConvert(bookID: "book1"))
        engine.consumeCredit(for: "book1")
        XCTAssertFalse(engine.canConvert(bookID: "book2"))
        engine.addCredits(2)
        XCTAssertTrue(engine.canConvert(bookID: "book2"))
    }
}
