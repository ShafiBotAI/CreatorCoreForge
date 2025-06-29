import XCTest
@testable import TradeMindAI

final class EntryExitAdvisorTests: XCTestCase {
    func testBuySignal() {
        let advisor = EntryExitAdvisor()
        let signal = advisor.signal(prices: [1, 2])
        XCTAssertEqual(signal, "BUY")
    }
}
