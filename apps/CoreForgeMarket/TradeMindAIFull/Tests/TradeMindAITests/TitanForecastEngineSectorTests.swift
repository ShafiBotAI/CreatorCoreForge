import XCTest
@testable import TradeMindAI

final class TitanForecastEngineSectorTests: XCTestCase {
    func testSectorHeatmap() {
        let engine = TitanForecastEngine()
        let data = ["tech": [1.0, 2.0, 3.0], "finance": [2.0, 2.0, 2.0]]
        let result = engine.generateSectorHeatmap(data: data, window: 3)
        XCTAssertEqual(result["tech"] ?? 0.0, 1.0, accuracy: 0.0001)
        XCTAssertEqual(result["finance"] ?? 0.0, 2.0, accuracy: 0.0001)
    }
}
