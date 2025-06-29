import XCTest
@testable import TradeMindAI

final class EarningsPreviewAITests: XCTestCase {
    func testForecastAverages() {
        let ai = EarningsPreviewAI()
        XCTAssertEqual(ai.forecast(previousEPS: [1,2,3]), 2)
    }
}
