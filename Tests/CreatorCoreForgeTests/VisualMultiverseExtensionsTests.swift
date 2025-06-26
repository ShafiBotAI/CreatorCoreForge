import XCTest
@testable import CreatorCoreForge

final class VisualMultiverseExtensionsTests: XCTestCase {
    func testAutoGenerateVariationsAndSync() {
        let manager = VisualMultiverseManager()
        manager.clearAll()
        let outcomes = manager.autoGenerateVariations(sceneID: "scene1", choices: ["Hero", "Villain"], project: "Book")
        XCTAssertEqual(outcomes.count, 2)
        manager.syncLayers(outcomeID: outcomes[0].id, voices: ["v"], fx: ["f"])
        let layers = manager.layers(for: outcomes[0].id)
        XCTAssertEqual(layers?.voices, ["v"])
        XCTAssertEqual(layers?.fx, ["f"])
    }

    func testDivergencePoints() {
        let manager = VisualMultiverseManager()
        manager.clearAll()
        _ = manager.autoGenerateVariations(sceneID: "s1", choices: ["A", "B"], project: "Book")
        _ = manager.autoGenerateVariations(sceneID: "s2", choices: ["Only"], project: "Book")
        let points = manager.divergencePoints(project: "Book")
        XCTAssertTrue(points.contains("s1"))
        XCTAssertFalse(points.contains("s2"))
    }

    func testViewerTrackerAndBranchAdvisor() {
        let tracker = ViewerNavigationTracker()
        tracker.record(viewerID: "u1", sceneID: "s1")
        tracker.record(viewerID: "u1", sceneID: "s2")
        XCTAssertEqual(tracker.path(for: "u1"), ["s1", "s2"])

        let advisor = TimelineBranchAdvisor()
        let rec = advisor.recommendation(for: "A")
        XCTAssertEqual(rec.palette, "Warm")
    }
}
