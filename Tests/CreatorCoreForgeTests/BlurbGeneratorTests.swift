import XCTest
@testable import CreatorCoreForge

final class BlurbGeneratorTests: XCTestCase {
    func testBlurbShortening() {
        let generator = BlurbGenerator()
        let text = "A very long story about heroes and villains that spans many years. " +
                   "It is filled with twists and turns and lessons learned."
        let blurb = generator.generateBlurb(from: text, maxLength: 50)
        XCTAssertTrue(blurb.count <= 53)
        XCTAssertTrue(blurb.hasSuffix("..."))
    }

    func testSynopsisAndBackCover() {
        let generator = BlurbGenerator()
        let text = "The hero rises. Darkness spreads. Hope remains."
        let synopsis = generator.generateSynopsis(from: text, sentenceLimit: 2)
        XCTAssertEqual(synopsis, "The hero rises. Darkness spreads.")
        let back = generator.generateBackCoverCopy(from: text)
        XCTAssertTrue(back.contains("The hero rises"))
        XCTAssertTrue(back.contains("Hope remains."))
    }
}
