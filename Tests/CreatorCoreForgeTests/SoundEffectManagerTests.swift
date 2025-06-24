import XCTest
@testable import CreatorCoreForge

final class SoundEffectManagerTests: XCTestCase {
    func testPlayAmbienceUpdatesState() {
        let manager = SoundEffectManager.shared
        manager.playAmbience(named: "Rain")
        XCTAssertEqual(manager.currentAmbience, "Rain")
    }

    func testStopAllResetsState() {
        let manager = SoundEffectManager.shared
        manager.playAmbience(named: "Cafe")
        manager.stopAllAmbience()
        XCTAssertEqual(manager.currentAmbience, "None")
    }
}
