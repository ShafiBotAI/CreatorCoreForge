import XCTest
@testable import TradeMindAI

final class AIAlertServiceTests: XCTestCase {
    func testAlertFormatsMessage() {
        let service = AIAlertService()
        XCTAssertEqual(service.alert(for: "Whale moved"), "ALERT: Whale moved")
    }
}
