import XCTest
@testable import CreatorCoreForge

final class DebuggingAssistantTests: XCTestCase {
    func testHints() {
        let assistant = DebuggingAssistant()
        let hints = assistant.hints(for: "Error")
        XCTAssertTrue(hints.first?.contains("Error") ?? false)
    }
}
