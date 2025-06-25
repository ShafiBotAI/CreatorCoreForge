import XCTest
@testable import CreatorCoreForge

final class VisualFeatureEnhancerTests: XCTestCase {
    func testShiftTimeline() {
        let enhancer = VisualFeatureEnhancer()
        let shifted = enhancer.shiftTimeline([1.0, 2.0], by: 1.5)
        XCTAssertEqual(shifted, [2.5, 3.5])
    }

    func testFXHistoryAndRecap() {
        var enhancer = VisualFeatureEnhancer()
        enhancer.recordFX(sceneID: "s1", fx: "flash")
        enhancer.recordFX(sceneID: "s1", fx: "glow")
        XCTAssertEqual(enhancer.fxHistory(for: "s1"), ["flash", "glow"])
        let recap = enhancer.generateRecap(from: enhancer.fxHistory(for: "s1"))
        XCTAssertEqual(recap, "flash|glow")
    }

    func testMultiversePreview() {
        let manager = VisualMultiverseManager()
        manager.clearAll()
        _ = manager.addOutcome(sceneID: "a", description: "alt", frames: [], project: "P")
        let enhancer = VisualFeatureEnhancer()
        let outcomes = enhancer.previewOutcomes(manager: manager, sceneID: "a", project: "P")
        XCTAssertEqual(outcomes.count, 1)
    }
}
