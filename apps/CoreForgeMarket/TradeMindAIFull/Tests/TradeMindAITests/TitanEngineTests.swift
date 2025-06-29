import XCTest
@testable import TradeMindAI

final class TitanEngineTests: XCTestCase {
    func testSMAForecast() {
        let engine = TitanEngine(smoothing: 0.5, maxHistory: 10, algorithm: .sma)
        [1.0, 2.0, 3.0].forEach { engine.log(price: $0) }
        XCTAssertEqual(engine.forecastNext() ?? 0.0, 2.0, accuracy: 0.0001)
    }
}
