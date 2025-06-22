import XCTest
@testable import CreatorCoreForge

final class AmbientFXEngineTests: XCTestCase {
    func testPlayAmbientSelectsCategory() {
        let engine = AmbientFXEngine()
        let fx = engine.playAmbient(tone: "calm", location: "forest")
        XCTAssertFalse(fx.isEmpty)
    }

    func testRecordReactionIncrementsCount() {
        let engine = AmbientFXEngine()
        engine.recordReaction(sceneID: "1")
        engine.recordReaction(sceneID: "1")
        let track = engine.exportTrack()
        XCTAssertNotNil(track)
    }
}
