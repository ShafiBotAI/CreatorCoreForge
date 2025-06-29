import XCTest
@testable import TradeMindAI

final class TrendShiftDetectorTests: XCTestCase {
    func testDetectsShift() {
        let detector = TrendShiftDetector()
        XCTAssertTrue(detector.detect(prices: [1,2,3,4,5]))
    }
}
