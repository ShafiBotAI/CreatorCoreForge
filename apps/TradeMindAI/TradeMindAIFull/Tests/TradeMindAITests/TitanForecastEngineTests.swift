import XCTest
@testable import TradeMindAI

final class TitanForecastEngineTests: XCTestCase {
    func testHeatmapNormalization() {
        let engine = TitanForecastEngine()
        [1,2,3,4,5].forEach { engine.log(Double($0)) }
        let heatmap = engine.generateHeatmap(window: 5)
        XCTAssertEqual(heatmap.first ?? 0.0, 0.0, accuracy: 0.0001)
        XCTAssertEqual(heatmap.last ?? 0.0, 1.0, accuracy: 0.0001)
    }
}
