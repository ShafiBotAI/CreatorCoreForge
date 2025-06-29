import XCTest
@testable import TradeMindAI

final class VoiceTradeAssistantTests: XCTestCase {
    func testHandleBuyCommand() {
        let assistant = VoiceTradeAssistant()
        XCTAssertEqual(assistant.handle(command: "buy now"), "order:buy")
    }
}
