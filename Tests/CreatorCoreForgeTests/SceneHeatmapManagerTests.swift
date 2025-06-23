import XCTest
@testable import CreatorCoreForge

final class SceneHeatmapManagerTests: XCTestCase {
    func testHeatmapGeneration() {
        let manager = SceneHeatmapManager()
        manager.log("happy", sceneID: "1")
        manager.log("sad", sceneID: "1")
        let map = manager.heatmap(for: "1")
        XCTAssertEqual(map.count, 2)
        XCTAssertEqual(map.first, 0.0)
        XCTAssertEqual(map.last, 1.0)
    }
}
