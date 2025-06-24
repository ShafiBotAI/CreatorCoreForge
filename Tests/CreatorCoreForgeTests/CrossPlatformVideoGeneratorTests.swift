import XCTest
@testable import CreatorCoreForge

final class CrossPlatformVideoGeneratorTests: XCTestCase {
    func testGenerate() {
        let generator = CrossPlatformVideoGenerator()
        let frames = ["a", "b"]
        XCTAssertEqual(generator.generate(frames: frames), frames)
    }
}
