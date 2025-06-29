import XCTest
@testable import TradeMindAI

final class TradeReplaySimulatorTests: XCTestCase {
    func testReplayReturnsTrades() {
        let sim = TradeReplaySimulator()
        sim.record("buy")
        XCTAssertEqual(sim.replay(), ["buy"])
    }
}
