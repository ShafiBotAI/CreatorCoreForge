import XCTest
@testable import CreatorCoreForge

final class AutoFormatDialogueTests: XCTestCase {
    func testFormatsDialogue() {
        let text = "Alice: Hello\nAlice: How are you?\nBob: I'm fine."
        let formatted = AutoFormatDialogue().format(text: text)
        let expected = "Alice:\n  Hello\n  How are you?\nBob:\n  I'm fine."
        XCTAssertEqual(formatted, expected)
    }
}
