import XCTest
@testable import TradeMindAI

final class SentimentTAOverlayTests: XCTestCase {
    func testOverlayAverages() {
        let overlay = SentimentTAOverlay()
        XCTAssertEqual(overlay.overlay(sentiment: 0.2, indicator: 0.4), 0.3)
    }
}
