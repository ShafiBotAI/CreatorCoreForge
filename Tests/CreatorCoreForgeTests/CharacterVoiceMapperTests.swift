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
        let result = mapper.assignVoices(to: text)
        XCTAssertEqual(result.count, 2)
        let aliceVoice = mapper.getVoice(for: "Alice")
        let bobVoice = mapper.getVoice(for: "Bob")
        XCTAssertNotNil(aliceVoice)
        XCTAssertNotNil(bobVoice)
        XCTAssertNotEqual(aliceVoice, bobVoice)
    }
}
