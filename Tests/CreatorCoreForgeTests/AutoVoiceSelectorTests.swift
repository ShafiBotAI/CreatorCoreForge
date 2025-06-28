import XCTest
@testable import CreatorCoreForge

final class AutoVoiceSelectorTests: XCTestCase {
    func testSelectVoicesDetectsAccents() {
        let text = """
        The story begins in London.
        Alice, the French spy: Bonjour.
        Bob from Germany: Guten tag.
        """
        let selector = AutoVoiceSelector()
        let result = selector.selectVoices(for: text)
        XCTAssertEqual(result.narrator, .british)
        let map = Dictionary(uniqueKeysWithValues: result.characters.map { ($0.name, $0.accent) })
        XCTAssertEqual(map["Alice"], .french)
        XCTAssertEqual(map["Bob"], .german)
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
