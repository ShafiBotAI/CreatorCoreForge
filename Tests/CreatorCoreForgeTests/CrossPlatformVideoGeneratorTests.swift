import XCTest
@testable import CreatorCoreForge

final class CrossPlatformVideoGeneratorTests: XCTestCase {
    func testGenerate() {
        let generator = CrossPlatformVideoGenerator()
        let frames = ["a", "b"]
        let clip = generator.generate(frames: frames, platform: .iOS)
        XCTAssertEqual(clip.frames, frames)
    }
}
