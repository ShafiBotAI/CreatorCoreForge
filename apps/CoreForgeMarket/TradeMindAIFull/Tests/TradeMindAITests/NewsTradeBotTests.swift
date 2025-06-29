import XCTest
@testable import TradeMindAI

final class NewsTradeBotTests: XCTestCase {
    func testGeneratesIdea() {
        let bot = NewsTradeBot()
        XCTAssertEqual(bot.idea(from: "Company beats earnings"), "consider buy")
    }
}
