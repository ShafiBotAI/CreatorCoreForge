import XCTest
@testable import TradeMindAI

final class PortfolioDNAVisualizerTests: XCTestCase {
    func testRiskBuckets() {
        let viz = PortfolioDNAVisualizer()
        let buckets = viz.riskBuckets(for: ["AAPL": 0.3, "TSLA": 0.1])
        XCTAssertEqual(buckets["high"], 1)
        XCTAssertEqual(buckets["low"], 1)
    }
}
