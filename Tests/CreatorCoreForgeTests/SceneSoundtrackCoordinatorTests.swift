import XCTest
@testable import CreatorCoreForge

final class SceneSoundtrackCoordinatorTests: XCTestCase {
    func testSoundtrackMoodMapping() {
        let coordinator = SceneSoundtrackCoordinator()
        let mood = coordinator.soundtrackMood(for: "Their eyes met in a tender kiss")
        XCTAssertEqual(mood, .romantic)
    }
}
