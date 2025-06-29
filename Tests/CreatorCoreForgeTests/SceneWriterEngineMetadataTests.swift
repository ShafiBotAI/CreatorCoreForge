import XCTest
@testable import CreatorCoreForge

final class SceneWriterEngineMetadataTests: XCTestCase {
    func testGenerateSceneParsesMetadata() {
        let engine = SceneWriterEngine()
        let scene = engine.generateScene(prompt: "[tone:dark][pov:first][emotion:anger]The hero enters.", memory: MemoryState())
        XCTAssertEqual(scene.tone, "dark")
        XCTAssertEqual(scene.pov, "first")
        XCTAssertEqual(scene.emotion, "anger")
        XCTAssertEqual(scene.text, "The hero enters.")
    }
}
