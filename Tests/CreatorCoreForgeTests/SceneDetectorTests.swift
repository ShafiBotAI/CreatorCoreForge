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
}
