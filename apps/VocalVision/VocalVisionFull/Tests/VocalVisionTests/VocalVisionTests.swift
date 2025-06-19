import XCTest
@testable import VocalVision

final class VocalVisionTests: XCTestCase {
    func testSceneGeneration() {
        let generator = VideoSceneGenerator()
        let scenes = generator.generateScenes(from: "A. B. C. D. E.", sentencesPerScene: 2)
        XCTAssertEqual(scenes.count, 3)
    }
}
