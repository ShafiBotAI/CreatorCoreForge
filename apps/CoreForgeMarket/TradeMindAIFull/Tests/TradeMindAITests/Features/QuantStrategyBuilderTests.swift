import XCTest
@testable import TradeMindAI

final class QuantStrategyBuilderTests: XCTestCase {
    func testBuildAddsRules() {
        let builder = QuantStrategyBuilder()
        let chart = builder.build(from: ["IF A THEN B", "IF B THEN C"])
        XCTAssertEqual(chart.steps.count, 2)
    }
}
