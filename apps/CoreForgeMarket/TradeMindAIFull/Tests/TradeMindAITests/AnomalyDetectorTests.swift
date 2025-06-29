import XCTest
@testable import TradeMindAI

final class AnomalyDetectorTests: XCTestCase {
    func testDetectAnomaly() {
        let detector = AnomalyDetector(threshold: 0.2)
        XCTAssertFalse(detector.detectAnomaly(in: [1.0, 1.1]))
        XCTAssertTrue(detector.detectAnomaly(in: [1.0, 1.5]))
    }
}
