import XCTest
@testable import CreatorCoreForge

final class SceneTimelineTests: XCTestCase {
    func testTimelineStoresClips() {
        let timeline = SceneTimeline()
        let clip = AudioClip(start: 0, duration: 1)
        timeline.addVoiceClip(for: "Alice", clip: clip)
        timeline.addAmbientClip(clip)
        timeline.addFXClip(clip)
        let result = timeline.timeline()
        XCTAssertEqual(result.voices["Alice"], [clip])
        XCTAssertEqual(result.ambient, [clip])
        XCTAssertEqual(result.fx, [clip])
    }
}
