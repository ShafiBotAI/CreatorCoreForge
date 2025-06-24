import XCTest
@testable import CreatorCoreForge

final class AdaptiveSceneCompletionTests: XCTestCase {
    func testCompleteScenesWithMemory() {
        let store = UserDefaults(suiteName: "AdaptiveSceneTest")!
        let memory = VisualMemoryEngine(store: store)
        memory.addFrame("past1", project: "Book")
        let completion = AdaptiveSceneCompletion(memory: memory)
        let exp = XCTestExpectation(description: "done")
        completion.completeScenes(["intro"], project: "Book", targetCount: 3) { scenes in
            XCTAssertGreaterThanOrEqual(scenes.count, 2)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2)
        store.removePersistentDomain(forName: "AdaptiveSceneTest")
    }
}
