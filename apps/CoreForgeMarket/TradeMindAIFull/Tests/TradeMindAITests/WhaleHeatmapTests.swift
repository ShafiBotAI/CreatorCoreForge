import XCTest
@testable import TradeMindAI

final class WhaleHeatmapTests: XCTestCase {
    func testGenerate() {
        let heatmap = WhaleHeatmap()
        let result = heatmap.generate(volumes: ["BTC": 10, "ETH": 5])
        XCTAssertEqual(result["BTC"], 1.0)
        XCTAssertEqual(result["ETH"], 0.5)
    }
}
