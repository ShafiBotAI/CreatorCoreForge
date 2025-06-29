import XCTest
@testable import TradeMindAI

final class PaperTradingSandboxTests: XCTestCase {
    func testBalanceUpdates() {
        let sandbox = PaperTradingSandbox(balance: 100)
        sandbox.buy(symbol: "AAPL", quantity: 1, price: 10)
        sandbox.sell(symbol: "AAPL", quantity: 1, price: 12)
        XCTAssertEqual(sandbox.currentBalance(), 102)
    }
}
