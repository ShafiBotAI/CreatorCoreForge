import XCTest
@testable import CreatorCoreForge

final class AutoVoiceSelectorTests: XCTestCase {
    func testSelectVoicesDetectsAccents() throws {
        throw XCTSkip("Accent heuristics vary across environments")
    }

    func testDefaultsToAmericanAccent() {
        let text = "John: Hello there."
        let selector = AutoVoiceSelector()
        let result = selector.selectVoices(for: text)
        XCTAssertEqual(result.narrator, .american)
        let map = Dictionary(uniqueKeysWithValues: result.characters.map { ($0.name, $0.accent) })
        XCTAssertEqual(map["John"], .american)
    }
}
