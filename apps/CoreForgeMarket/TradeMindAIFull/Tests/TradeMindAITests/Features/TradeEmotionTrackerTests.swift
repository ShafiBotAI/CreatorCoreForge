import XCTest
@testable import TradeMindAI

final class TradeEmotionTrackerTests: XCTestCase {
    func testRecordAndSummary() {
        let tracker = TradeEmotionTracker()
        tracker.record("FOMO")
        XCTAssertEqual(tracker.summary["FOMO"], 1)
    }
}
