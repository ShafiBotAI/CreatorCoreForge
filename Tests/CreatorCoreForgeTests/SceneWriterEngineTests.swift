import XCTest
@testable import CreatorCoreForge

final class SceneWriterEngineTests: XCTestCase {
    func testGenerateSceneCreatesDraft() {
        let engine = SceneWriterEngine()
        let scene = engine.generateScene(prompt: "Test scene", memory: MemoryState())
        XCTAssertEqual(scene.text, "Test scene")
        XCTAssertFalse(scene.id.uuidString.isEmpty)
        XCTAssertFalse(scene.chapterID.uuidString.isEmpty)
    }
}
