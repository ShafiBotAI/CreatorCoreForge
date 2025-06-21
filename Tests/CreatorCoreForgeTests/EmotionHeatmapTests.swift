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
=======
        let heatmap = EmotionHeatmap()
        heatmap.log(emotion: "sad", intensity: 0.1)
        heatmap.log(emotion: "neutral", intensity: 0.5)
        heatmap.log(emotion: "happy", intensity: 0.9)
        let result = heatmap.generateHeatmap(window: 3)
        XCTAssertEqual(result.first ?? -1.0, 0.0, accuracy: 0.0001)
        XCTAssertEqual(result.last ?? -1.0, 1.0, accuracy: 0.0001)

    }
}
