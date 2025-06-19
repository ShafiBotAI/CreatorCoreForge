import XCTest
@testable import TradeMindAI

final class SentimentHeatmapTests: XCTestCase {
    func testHeatmapNormalization() {
        let map = SentimentHeatmap()
        map.log("bear panic")
        map.log("nothing special")
        map.log("optimistic bull")
        let result = map.generateHeatmap(window: 3)
        XCTAssertEqual(result.first ?? 1.0, 0.0, accuracy: 0.0001)
        XCTAssertEqual(result.last ?? 0.0, 1.0, accuracy: 0.0001)
        XCTAssertEqual(result[1], 0.5, accuracy: 0.0001)
    }
}
