import XCTest
@testable import CreatorCoreForge

final class HistoricalTimePeriodCheckerTests: XCTestCase {
    func testDetectsMedieval() {
        let text = "The knight raised his sword outside the ancient castle."
        let periods = HistoricalTimePeriodChecker.detectPeriods(in: text)
        XCTAssertTrue(periods.contains("Medieval"))
        XCTAssertFalse(periods.contains("Modern"))
    }
}
