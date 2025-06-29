import XCTest
@testable import TradeMindAI

final class ShadowTraderTests: XCTestCase {
    func testReplicatePatternEchoes() {
        let trader = ShadowTrader(exchange: ExchangeAPI())
        let pattern = [1.0, 2.0, 3.0]
        XCTAssertEqual(trader.replicatePattern(pattern), pattern)
    }
}
