import XCTest
@testable import CreatorCoreForge

final class SceneMemorySimulatorTests: XCTestCase {
    func testSaveAndRecallScene() {
        let sim = SceneMemorySimulator.shared
        sim.clearMemory()
        sim.saveScene(book: "Book", chapter: "1", sceneID: "S1", emotion: "happy", voiceDNA: "v1")
        let scenes = sim.recallScenes(for: "Book")
        XCTAssertEqual(scenes.count, 1)
        sim.deleteScene(scenes[0])
        XCTAssertTrue(sim.recallScenes(for: "Book").isEmpty)
    }
}
