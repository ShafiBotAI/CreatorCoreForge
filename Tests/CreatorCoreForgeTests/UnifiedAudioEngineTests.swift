import XCTest
@testable import CreatorCoreForge

final class UnifiedAudioEngineTests: XCTestCase {
    func testVolumeClamped() {
        let engine = UnifiedAudioEngine.shared
        engine.setVolume(1.5)
        XCTAssertEqual(engine.currentVolume(), 1.0)
        engine.setVolume(-0.5)
        XCTAssertEqual(engine.currentVolume(), 0.0)
    }

    func testMuteToggle() {
        let engine = UnifiedAudioEngine.shared
        engine.unmute()
        engine.mute()
        XCTAssertTrue(engine.isMuted)
    }
}
