import XCTest
@testable import CreatorCoreForge

final class UniversalMediaGeneratorTests: XCTestCase {
    func testGenerate() {
        let generator = UniversalMediaGenerator()
        let media = generator.generate(from: "A. B.")
        XCTAssertFalse(media.audioTrack.isEmpty)
        XCTAssertFalse(media.clip.frames.isEmpty)
        XCTAssertTrue(media.actions.contains("generateAudio"))
        XCTAssertTrue(media.actions.contains("generateVideo"))
    }
}
