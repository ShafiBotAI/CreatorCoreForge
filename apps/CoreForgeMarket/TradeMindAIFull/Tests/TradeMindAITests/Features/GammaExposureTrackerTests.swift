import XCTest
@testable import TradeMindAI

final class GammaExposureTrackerTests: XCTestCase {
    func testTotalGamma() {
        let tracker = GammaExposureTracker()
        let positions = [OptionPosition(delta: 0.1, gamma: 0.2, quantity: 10)]
        XCTAssertEqual(tracker.totalGamma(for: positions), 2.0)
    }
}
