import XCTest
@testable import TradeMindAI

final class HedgingAdvisorTests: XCTestCase {
    func testSuggestHedge() {
        let advisor = HedgingAdvisor()
        XCTAssertEqual(advisor.suggestHedge(volatility: 0.1), "No hedge needed")
        XCTAssertEqual(advisor.suggestHedge(volatility: 0.3), "Consider protective puts")
        XCTAssertEqual(advisor.suggestHedge(volatility: 0.8), "Strong hedge recommended")
    }
}
