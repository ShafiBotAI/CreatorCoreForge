import XCTest
@testable import TradeMindAI

final class NeuralSignalRebalancerTests: XCTestCase {
    func testRebalance() {
        let reb = NeuralSignalRebalancer()
        let result = reb.rebalance(signals: [1, 1, 1], volatility: 0.5)
        XCTAssertEqual(result.reduce(0, +), 3.0, accuracy: 0.001)
    }
}
