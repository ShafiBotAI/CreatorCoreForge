import XCTest
@testable import TradeMindAI

final class PortfolioRiskSimulatorTests: XCTestCase {
    func testRecommendedRisk() {
        let service = OpenAIService(apiKey: "TEST")
        let sim = PortfolioRiskSimulator(service: service)
        XCTAssertEqual(sim.recommendedRisk(for: .conservative), 0.02)
        XCTAssertEqual(sim.recommendedRisk(for: .balanced), 0.05)
        XCTAssertEqual(sim.recommendedRisk(for: .aggressive), 0.1)
    }
}
