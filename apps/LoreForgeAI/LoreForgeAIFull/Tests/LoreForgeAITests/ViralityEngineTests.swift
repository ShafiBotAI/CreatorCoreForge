import XCTest
@testable import LoreForgeAI

final class ViralityEngineTests: XCTestCase {
    func testShockEffectReturnsSameURL() {
        let url = URL(fileURLWithPath: "/tmp/video.mp4")
        let engine = ViralEngine()
        let result = engine.applyShockEffect(to: url)
        XCTAssertEqual(result, url)
    }

    func testLoopVideoReturnsSameURL() {
        let url = URL(fileURLWithPath: "/tmp/video.mp4")
        let engine = ViralEngine()
        let result = engine.loopVideo(at: url, count: 2)
        XCTAssertEqual(result, url)
    }
}
