import XCTest
@testable import CreatorCoreForge

final class SceneMemorySimulatorTests: XCTestCase {
    func testSaveRecallAndDelete() {
        let simulator = SceneMemorySimulator()
        simulator.saveScene(book: "Book", chapter: "1", sceneID: "s1", emotion: "happy", voiceDNA: "v1")
        simulator.saveScene(book: "Book", chapter: "2", sceneID: "s2", emotion: "sad", voiceDNA: "v2")
        XCTAssertEqual(simulator.recallScenes(for: "Book").count, 2)

        if let scene = simulator.recallScenes(for: "Book").first {
            simulator.deleteScene(scene)
        }
        XCTAssertEqual(simulator.recallScenes(for: "Book").count, 1)

        simulator.clearMemory()
        XCTAssertTrue(simulator.recallScenes(for: "Book").isEmpty)
    }
}
