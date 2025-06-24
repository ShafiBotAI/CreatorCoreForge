import XCTest
@testable import CreatorCoreForge

final class LongFormPacingEngineTests: XCTestCase {
    func testSuggestedPace() {
        let short = Chapter(title: "short", text: String(repeating: "word ", count: 100), order: 1)
        let long = Chapter(title: "long", text: String(repeating: "word ", count: 60000), order: 2)
        let engine = LongFormPacingEngine()
        XCTAssertEqual(engine.suggestedPace(for: [short]), 1.0)
        XCTAssertEqual(engine.suggestedPace(for: [long]), 1.3)
    }
}
