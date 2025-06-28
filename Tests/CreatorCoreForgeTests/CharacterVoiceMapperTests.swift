import XCTest
@testable import CreatorCoreForge

final class CharacterVoiceMapperTests: XCTestCase {
    func testAssignsUniqueVoices() {
        let mapper = CharacterVoiceMapper()
        let text = """
        Alice: Hello
        Bob: Hi
        Alice: How are you?
        """
        let result = mapper.assignVoicesSelective(to: text)
        XCTAssertEqual(result.count, 2)
        let aliceVoice = mapper.getVoice(for: "Alice")
        let bobVoice = mapper.getVoice(for: "Bob")
        XCTAssertNotNil(aliceVoice)
        XCTAssertNotNil(bobVoice)
        XCTAssertNotEqual(aliceVoice, bobVoice)
    }

    func testParsesDashSeparatedDialogue() {
        let mapper = CharacterVoiceMapper(voices: ["One", "Two"])
        let text = """
        Alice - Hello
        Bob — Hi there
        """
        let result = mapper.assignVoicesSelective(to: text)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.map { $0.assignedVoice }, ["One", "Two"])
    }

    func testManualSelectionForFrequentSpeakers() {
        let mapper = CharacterVoiceMapper(voices: ["Auto1", "Auto2"])
        let speech = Array(repeating: "Hello.", count: 11).joined(separator: " ")
        let text = "Alice: \(speech)\nBob: Hi."
        var selected: [String] = []
        let result = mapper.assignVoicesSelective(to: text) { name, _ in
            selected.append(name)
            return "Manual"
        }
        XCTAssertTrue(selected.contains("Alice"))
        XCTAssertFalse(selected.contains("Bob"))
        let alice = result.first { $0.name == "Alice" }!
        let bob = result.first { $0.name == "Bob" }!
        XCTAssertEqual(alice.assignedVoice, "Manual")
        XCTAssertEqual(bob.assignedVoice, "Auto1")
    }
}
