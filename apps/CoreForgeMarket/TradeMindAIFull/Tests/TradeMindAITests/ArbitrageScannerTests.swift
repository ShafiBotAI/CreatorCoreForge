import XCTest
@testable import TradeMindAI

final class ArbitrageScannerTests: XCTestCase {
    func testFindOpportunities() {
        let prices = [
            "BTC": ["A": 10.0, "B": 12.0],
            "ETH": ["A": 5.0, "B": 5.0]
        ]
        let scanner = ArbitrageScanner()
        let ops = scanner.findOpportunities(prices: prices)
        XCTAssertEqual(ops.count, 1)
        XCTAssertEqual(ops.first?.symbol, "BTC")
        XCTAssertEqual(ops.first?.profit, 2.0)
    }
}
