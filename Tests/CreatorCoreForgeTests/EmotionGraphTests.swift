import XCTest
@testable import CreatorCoreForge

final class EmotionGraphTests: XCTestCase {
    func testAverageIntensity() {
        let graph = EmotionGraph()
        graph.record(emotion: "happy", intensity: 0.5)
        graph.record(emotion: "happy", intensity: 1.0)
        XCTAssertEqual(graph.averageIntensity(for: "happy"), 0.75)
    }

    func testExportImport() {
        let graph = EmotionGraph()
        graph.record(emotion: "sad", intensity: 0.3)
        let data = graph.export()
        let newGraph = EmotionGraph()
        if let data = data {
            newGraph.import(data: data)
        }
        XCTAssertEqual(newGraph.averageIntensity(for: "sad"), 0.3)
    }
}
