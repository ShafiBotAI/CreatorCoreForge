import XCTest
@testable import CreatorCoreForge

final class AmbientPhase3FeatureTests: XCTestCase {
    func testDetectAndApplyTransitionReturnsFX() {
        let engine = AmbientFXEngine()
        let fx = engine.detectAndApplyTransition(narrationLine: "The hero entered the forest.")
        XCTAssertNotNil(fx)
    }

    func testSyncWithPauseMutesEngine() {
        let engine = AmbientFXEngine()
        engine.syncWithNarrationPause(true)
        XCTAssertTrue(engine.isMuted)
        engine.syncWithNarrationPause(false)
        XCTAssertFalse(engine.isMuted)
    }

    func testSceneFXPresetLookup() {
        let preset = SceneFXPresets.preset(named: "Haunted Mansion")
        XCTAssertTrue(preset.contains("door_creak"))
    }

    func testPreviewerString() {
        let result = AmbientPreviewer.preview(scene: "intro", voice: "narrator", fx: ["rain"])
        XCTAssertTrue(result.contains("narrator"))
    }
}
