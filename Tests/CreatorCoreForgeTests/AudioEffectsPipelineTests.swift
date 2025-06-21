import XCTest
@testable import CreatorCoreForge

final class AudioEffectsPipelineTests: XCTestCase {
    func testAddEcho() {
        let pipeline = AudioEffectsPipeline()
        let result = pipeline.addEcho(to: ["s1", "s2"])
        XCTAssertEqual(result, ["s1", "s1-echo", "s2", "s2-echo"])
    }

    func testShiftPitch() {
        let pipeline = AudioEffectsPipeline()
        let result = pipeline.shiftPitch(of: ["s1"], factor: 1.2)
        XCTAssertEqual(result.first, "s1|pitch:1.2")
    }

    func testMix() {
        let pipeline = AudioEffectsPipeline()
        let track = pipeline.mix(samples: ["a", "b"])
        XCTAssertEqual(track, "a+b")
    }
}

