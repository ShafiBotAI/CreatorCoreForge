import XCTest
@testable import TradeMindAI

final class StrategyFlowchartTests: XCTestCase {
    func testAddStepAppends() {
        let flow = StrategyFlowchart()
        flow.addStep("start")
        XCTAssertEqual(flow.steps, ["start"])
    }
}
