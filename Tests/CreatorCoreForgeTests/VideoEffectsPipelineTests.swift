import XCTest
@testable import CreatorCoreForge

final class VideoEffectsPipelineTests: XCTestCase {
    func testFadeTransitions() {
        let pipeline = VideoEffectsPipeline()
        let result = pipeline.applyFadeTransitions(to: ["f1", "f2", "f3"])
        XCTAssertEqual(result, ["f1", "fade", "f2", "fade", "f3"])
    }

    func testAddWatermark() {
        let pipeline = VideoEffectsPipeline()
        let result = pipeline.addWatermark(to: ["f1", "f2"], watermark: "WM")
        XCTAssertEqual(result, ["f1-WM", "f2-WM"])
    }

    func testFadeInOut() {
        let pipeline = VideoEffectsPipeline()
        let result = pipeline.applyFadeInOut(to: ["f1", "f2"])
        XCTAssertEqual(result, ["fade-in", "f1", "f2", "fade-out"])
    }

    func testComposeVideo() {
        let pipeline = VideoEffectsPipeline()
        let clip = pipeline.composeVideo(frames: ["f1"], audio: "track")
        XCTAssertEqual(clip.frames.first, "f1|audio:track")
    }

    func testInterpolateFrames() {
        let pipeline = VideoEffectsPipeline()
        let result = pipeline.interpolateFrames(["a", "b"])
        XCTAssertEqual(result, ["a", "a_b_interp", "b"])
    }
}
