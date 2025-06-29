import XCTest
@testable import TradeMindAI

final class TradeCoachTests: XCTestCase {
    func testGradesProfit() {
        let coach = TradeCoach()
        let grade = coach.grade(decision: TradeDecision(entry: 1, exit: 2))
        XCTAssertEqual(grade, "Good")
    }
}
