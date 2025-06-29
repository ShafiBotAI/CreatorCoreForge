import XCTest
@testable import CreatorCoreForge

final class SceneManagerFeaturesTests: XCTestCase {
    func testAlternateAndPin() {
        let scene = SceneDraft(chapterID: UUID(), text: "A")
        let manager = SceneManager(scenes: [scene])
        manager.toggleActive(sceneID: scene.id) // deactivate
        manager.addAlternateScene(for: scene.id, draft: SceneDraft(chapterID: scene.chapterID, text: "Alt"))
        manager.pinScene(id: scene.id)
        XCTAssertEqual(manager.activeScenes().count, 0)
        XCTAssertEqual(manager.alternateScenes(for: scene.id).first?.text, "Alt")
        XCTAssertEqual(manager.pinnedSceneID, scene.id)
    }
}
