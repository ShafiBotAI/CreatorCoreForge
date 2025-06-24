import XCTest
@testable import CreatorCoreForge

final class VisualMultiverseManagerTests: XCTestCase {
    func testAddAndQueryOutcomes() {
        let manager = VisualMultiverseManager()
        manager.clearAll()
        let outcome1 = manager.addOutcome(sceneID: "1", description: "alt A", frames: ["f1"], project: "Book")
        let outcome2 = manager.addOutcome(sceneID: "1", description: "alt B", frames: ["f2"], project: "Book")
        let results = manager.outcomes(for: "1", project: "Book")
        XCTAssertEqual(results.count, 2)
        XCTAssertTrue(results.contains(outcome1))
        XCTAssertTrue(results.contains(outcome2))
        let map = manager.multiverseMap(for: "Book")
        XCTAssertEqual(map["1"], 2)
    }

    func testRemoveOutcome() {
        let manager = VisualMultiverseManager()
        manager.clearAll()
        let outcome = manager.addOutcome(sceneID: "s", description: "d", frames: [], project: "P")
        manager.removeOutcome(outcome.id)
        XCTAssertTrue(manager.outcomes(for: "s", project: "P").isEmpty)
    }
}
