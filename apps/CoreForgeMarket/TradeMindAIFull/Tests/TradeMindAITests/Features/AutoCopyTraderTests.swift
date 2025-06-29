import XCTest
@testable import TradeMindAI

final class AutoCopyTraderTests: XCTestCase {
    func testMirroredSize() {
        let trader = AutoCopyTrader(riskMultiplier: 0.5)
        XCTAssertEqual(trader.mirroredSize(leaderSize: 10), 5)
    }
}
