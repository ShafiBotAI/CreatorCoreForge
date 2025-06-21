import XCTest
@testable import CreatorCoreForge

final class HybridQuantumTradingEngineTests: XCTestCase {
    func testEvaluateSignals() {
        let engine = HybridQuantumTradingEngine()
        XCTAssertEqual(engine.evaluateSignals([1, 2, 3]), "BUY")
        XCTAssertEqual(engine.evaluateSignals([3, 2, 1]), "SELL")
    }
}
