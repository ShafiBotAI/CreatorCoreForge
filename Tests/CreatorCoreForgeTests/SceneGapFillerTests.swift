import XCTest
@testable import CreatorCoreForge

final class SceneGapFillerTests: XCTestCase {
    func testFillGapsAddsScenes() {
        let filler = SceneGapFiller(engine: LocalAIEnginePro())
        let expectation = XCTestExpectation(description: "fill")
        filler.fillGaps(in: ["Intro", ""]) { scenes in
            XCTAssertGreaterThanOrEqual(scenes.count, 3)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    func testGenerateAnimationFrames() {
        let filler = SceneGapFiller()
        let frames = filler.generateAnimationFrames(for: "Test")
        XCTAssertEqual(frames.count, 3)
    }
}
