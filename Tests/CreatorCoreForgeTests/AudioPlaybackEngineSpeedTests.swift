import XCTest
@testable import CreatorCoreForge

final class AudioPlaybackEngineSpeedTests: XCTestCase {
    func testSpeedClamped() {
        let engine = AudioPlaybackEngine()
        engine.setSpeed(10)
        XCTAssertEqual(engine.currentSpeed(), 10.0, accuracy: 0.0001)
        engine.setSpeed(0.1)
        XCTAssertEqual(engine.currentSpeed(), 0.5, accuracy: 0.0001)
    }
}
