import XCTest
@testable import CreatorCoreForge

final class CharacterDetectionEngineTests: XCTestCase {
    func testDetectsNames() {
        let engine = CharacterDetectionEngine()
        let text = "Alice went to the market. Bob said hello to Alice."
        let names = engine.detectNames(in: text)
        XCTAssertTrue(names.contains("Alice"))
        XCTAssertTrue(names.contains("Bob"))
    }

    func testDetectsPronouns() {
        let engine = CharacterDetectionEngine()
        let text = "She looked at him and they smiled."
        let pronouns = engine.detectPronouns(in: text)
        XCTAssertEqual(pronouns, Set(["she", "him", "they"]))
    }
}
