import XCTest
@testable import CreatorCoreForge

final class VisualMemoryEngineTests: XCTestCase {
    func testTimelinePersistence() {
        let suite = UserDefaults(suiteName: "VisualMemTest")!
        var engine: VisualMemoryEngine? = VisualMemoryEngine(store: suite)
        engine?.addFrame("f1", project: "Book1")
        engine?.addFrame("f2", project: "Book2")
        engine = nil
        let loaded = VisualMemoryEngine(store: suite)
        XCTAssertEqual(loaded.frames(for: "Book1"), ["f1"])
        XCTAssertEqual(loaded.allFramesTimeline(), ["f1", "f2"])
        suite.removePersistentDomain(forName: "VisualMemTest")
    }

    func testRemoveFrames() {
        let suite = UserDefaults(suiteName: "VisualMemRemoveTest")!
        let engine = VisualMemoryEngine(store: suite)
        engine.addFrame("a", project: "P1")
        engine.addFrame("b", project: "P1")
        engine.addFrame("c", project: "P2")
        engine.removeFrames(for: "P1")
        XCTAssertEqual(engine.frames(for: "P1"), [])
        XCTAssertEqual(engine.allFramesTimeline(), ["c"])
        suite.removePersistentDomain(forName: "VisualMemRemoveTest")
    }

    func testLastFrame() {
        let suite = UserDefaults(suiteName: "VisualMemLastTest")!
        let engine = VisualMemoryEngine(store: suite)
        engine.addFrame("a", project: "P1")
        engine.addFrame("b", project: "P1")
        XCTAssertEqual(engine.lastFrame(for: "P1"), "b")
        suite.removePersistentDomain(forName: "VisualMemLastTest")
    }
}
