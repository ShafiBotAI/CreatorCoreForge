import XCTest
@testable import TradeMindAI

final class TokenomicsVisualizerTests: XCTestCase {
    func testSummary() {
        let token = Tokenomics(circulatingSupply: 50, maxSupply: 100, marketCap: 200, volume24h: 20)
        let vis = TokenomicsVisualizer()
        let text = vis.summary(for: token)
        XCTAssertTrue(text.contains("Supply"))
    }
}
