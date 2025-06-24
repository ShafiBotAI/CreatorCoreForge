import XCTest
@testable import CreatorCoreForge

final class SceneDetectorTests: XCTestCase {
    func testAnalyzeSplitsScenesAndDetectsSentiment() {
        let text = "A good day.\n\nA bad night."
        let detector = SceneDetector()
        let map = detector.analyze(text: text)
        XCTAssertEqual(map.scenes.count, 2)
        XCTAssertEqual(map.scenes[0].sentiment, .positive)
        XCTAssertEqual(map.scenes[1].sentiment, .negative)
    }

    func testDetectsTimeAndLocationShifts() {
        let text = "It was sunny.\n\nThe next day they were in Paris.\n\nA week later they visited London." 
        let detector = SceneDetector()
        let map = detector.analyze(text: text)
        XCTAssertEqual(map.scenes.count, 3)
        XCTAssertTrue(map.scenes[1].shifts.contains(.timeJump))
        XCTAssertFalse(map.scenes[1].shifts.contains(.locationChange))
        XCTAssertTrue(map.scenes[2].shifts.contains(.timeJump))
        XCTAssertTrue(map.scenes[2].shifts.contains(.locationChange))
    }
}
