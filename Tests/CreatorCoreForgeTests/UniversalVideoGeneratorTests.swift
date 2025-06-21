import XCTest
@testable import CreatorCoreForge

final class UniversalVideoGeneratorTests: XCTestCase {
    func testGenerateClip() {
        let generator = UniversalVideoGenerator()
        let clip = generator.generateClip(text: "Hello", style: .anime, audio: "track")
        XCTAssertTrue(clip.frames.contains { $0.contains("audio:track") })
    }
}
