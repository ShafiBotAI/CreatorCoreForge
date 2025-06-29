import XCTest
@testable import TradeMindAI

final class LiquidityTrapDetectorTests: XCTestCase {
    func testIsTrap() {
        let detector = LiquidityTrapDetector()
        let result = detector.isTrap(volumes: [1,1,5], threshold: 2)
        XCTAssertTrue(result)
    }
}
