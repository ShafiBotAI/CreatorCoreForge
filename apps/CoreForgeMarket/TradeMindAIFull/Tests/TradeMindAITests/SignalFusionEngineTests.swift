import XCTest
@testable import TradeMindAI

final class SignalFusionEngineTests: XCTestCase {
    func testFusesSignals() {
        let engine = SignalFusionEngine()
        let value = engine.fuse([1, 2, 3])
        XCTAssertEqual(value, 2)
    }
}
