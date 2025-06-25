import XCTest
@testable import CreatorCoreForge

final class SceneParserEngineTests: XCTestCase {
    func testParseScenesFromText() {
        let engine = SceneParserEngine()
        let scenes = engine.parseScenes(from: "A hero rises. A villain plots.")
        XCTAssertEqual(scenes.count, 2)
        XCTAssertEqual(scenes.first?.tone, .neutral)
    }

    func testParseScenesFromChapters() async throws {
        let chapter = Chapter(title: "One", text: "Hello world.", order: 0, metadata: nil)
        let engine = SceneParserEngine()
        let scenes = engine.parseScenes(from: [chapter])
        XCTAssertEqual(scenes.count, 1)
        XCTAssertEqual(scenes[0].characters.count, 0)
    }
}
