import XCTest
@testable import CreatorCoreForge

final class NSFWMoodHeatmapTests: XCTestCase {
    func testHeatmapNormalization() {
        let heatmap = NSFWMoodHeatmap()
        heatmap.log(intensity: .softcore)
        heatmap.log(intensity: .rough)
        heatmap.log(intensity: .hardcore)
        let result = heatmap.generateHeatmap(window: 3)
        XCTAssertEqual(result.first ?? -1.0, 0.0, accuracy: 0.0001)
        XCTAssertEqual(result.last ?? -1.0, 1.0, accuracy: 0.0001)
    }
}
