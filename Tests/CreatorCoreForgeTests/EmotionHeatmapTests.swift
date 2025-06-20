import XCTest
@testable import CreatorCoreForge

final class EmotionHeatmapTests: XCTestCase {
    func testHeatmapNormalization() {
        let map = EmotionHeatmap()
        map.log("Feeling okay")
        map.log("I am furious!")
        map.log("Absolutely ecstatic!!!")
        let result = map.generateHeatmap(window: 3)
        XCTAssertEqual(result.first ?? 1.0, 0.0, accuracy: 0.0001)
        XCTAssertEqual(result[1], 1.0, accuracy: 0.0001)
        XCTAssertEqual(result.last ?? 0.0, 0.5, accuracy: 0.0001)
    }
}
