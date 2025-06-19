import XCTest
@testable import DataForgeAI

final class MarketplaceCreditSystemTests: XCTestCase {
    func testCreditConsumptionAndTopUp() {
        let credits = MarketplaceCreditSystem(initialCredits: 10)
        XCTAssertTrue(credits.consumeCredits(5))
        XCTAssertEqual(credits.balance, 5)
        XCTAssertFalse(credits.consumeCredits(10))
        credits.addCredits(15)
        XCTAssertEqual(credits.balance, 20)
        XCTAssertTrue(credits.consumeCredits(20))
        XCTAssertEqual(credits.balance, 0)
    }
}
