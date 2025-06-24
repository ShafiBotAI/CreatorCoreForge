import XCTest
@testable import CreatorCoreForge

final class AIVocalProductionEngineTests: XCTestCase {
    func testProcess() {
        let engine = AIVocalProductionEngine()
        let processed = engine.process(track: [0.5, 1.0, 0.25])
        XCTAssertEqual(processed.max(), 1.0)
    }
}
