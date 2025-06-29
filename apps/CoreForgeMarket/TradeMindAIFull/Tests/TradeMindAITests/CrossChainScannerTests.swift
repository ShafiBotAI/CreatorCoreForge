import XCTest
@testable import TradeMindAI

final class CrossChainScannerTests: XCTestCase {
    func testDetectsOpportunity() {
        let scanner = CrossChainScanner()
        let data = ["TOKEN": ["chainA": 1.0, "chainB": 1.2]]
        XCTAssertEqual(scanner.scan(chains: data), ["TOKEN"])
    }
}
