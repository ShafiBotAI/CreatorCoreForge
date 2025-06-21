import XCTest
@testable import CreatorCoreForge

final class NextGenAudioGeneratorTests: XCTestCase {
    func testGenerateLoopsActivatesLayers() {
        let generator = NextGenAudioGenerator()
        let urls = generator.generateLoops(for: ["calm", "tense"])
        XCTAssertEqual(urls.count, 2)
        XCTAssertEqual(generator.activeLayers, ["calm", "tense"])
    }
}
