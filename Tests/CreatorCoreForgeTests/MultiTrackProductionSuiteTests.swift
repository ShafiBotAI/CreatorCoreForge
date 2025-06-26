import XCTest
@testable import CreatorCoreForge

final class MultiTrackProductionSuiteTests: XCTestCase {
    func testProduce() {
        let suite = MultiTrackProductionSuite()
        let tracks = [
            ProductionTrack(name: "v1", samples: [1,2]),
            ProductionTrack(name: "v2", samples: [1])
        ]
        let result = suite.produce(tracks: tracks, frames: ["f1", "f2"], watermark: "wm")
        XCTAssertEqual(result.audioMix[0], 2)
        XCTAssertEqual(result.frames.first, "f1-wm(wm)")
    }
}
