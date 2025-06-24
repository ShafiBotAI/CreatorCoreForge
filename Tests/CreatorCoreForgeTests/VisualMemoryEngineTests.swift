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
}
