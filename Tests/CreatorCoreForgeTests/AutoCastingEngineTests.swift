import XCTest
@testable import CreatorCoreForge

final class AutoCastingEngineTests: XCTestCase {
    func testSuggestVoice() {
        let engine = AutoCastingEngine()
        let profile = engine.suggestVoice(for: "fantasy", tone: "heroic")
        XCTAssertEqual(profile.emotion, "heroic")
        XCTAssertTrue(profile.name.contains("Fantasy"))
    }
}
