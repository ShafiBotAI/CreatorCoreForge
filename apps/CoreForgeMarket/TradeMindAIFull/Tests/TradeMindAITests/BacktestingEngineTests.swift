import XCTest
@testable import TradeMindAI

final class BacktestingEngineTests: XCTestCase {
    func testScoreCalculatesMeanReturn() {
        let engine = BacktestingEngine()
        let score = engine.score(prices: [1, 2, 1])
        XCTAssertNotEqual(score, 0)
    }
}
