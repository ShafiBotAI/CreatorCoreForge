import XCTest
@testable import VerseForgeAI

final class ViralEngineTests: XCTestCase {
    func testLoopReturnsSameURL() {
        let url = URL(fileURLWithPath: "/tmp/video.mp4")
        let engine = ViralEngine()
        let result = engine.loopVideo(at: url, count: 2)
        XCTAssertEqual(result, url)
    }
}
