import XCTest
@testable import CreatorCoreForge

final class MultiCastAudiobookGeneratorTests: XCTestCase {
    func testGenerateScenesCombinesSegments() {
        let chapters = [[
            POVSegment(character: "Alice", text: "Hello"),
            POVSegment(character: "Bob", text: "Hi")
        ]]
        let generator = MultiCastAudiobookGenerator()
        let scenes = generator.generateScenes(from: chapters)
        XCTAssertEqual(scenes.count, 1)
        XCTAssertTrue(scenes[0].contains("Alice: Hello"))
        XCTAssertTrue(scenes[0].contains("Bob: Hi"))
    }
}
