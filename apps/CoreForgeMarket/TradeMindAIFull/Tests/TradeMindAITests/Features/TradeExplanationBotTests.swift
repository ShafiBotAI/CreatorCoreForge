import XCTest
@testable import TradeMindAI

final class TradeExplanationBotTests: XCTestCase {
    func testExplainGeneratesSummary() {
        let bot = TradeExplanationBot()
        let desc = bot.explain(trade: Trade(symbol: "AAPL", action: "buy", quantity: 5))
        XCTAssertEqual(desc, "Buy 5 of AAPL")
    }
}
