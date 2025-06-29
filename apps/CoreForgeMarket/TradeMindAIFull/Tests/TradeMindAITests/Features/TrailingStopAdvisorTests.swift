import XCTest
@testable import TradeMindAI

final class TrailingStopAdvisorTests: XCTestCase {
    func testStopPriceLowerThanCurrent() {
        let advisor = TrailingStopAdvisor()
        let price = advisor.stopPrice(current: 100, volatility: 0.5)
        XCTAssertLessThan(price, 100)
    }
}
