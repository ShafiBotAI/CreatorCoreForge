import XCTest
@testable import DataForgeAI

final class PersonaRecommenderTests: XCTestCase {
    func testRecommendTopPersona() {
        let leads = [
            Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US"),
            Lead(name: "B", email: "b@b.com", company: "Beta", industry: "Tech", region: "US"),
            Lead(name: "C", email: "c@c.com", company: "Gamma", industry: "Retail", region: "EU")
        ]
        let recommender = PersonaRecommender()
        let personas = recommender.recommend(from: leads, top: 1)
        XCTAssertEqual(personas.first?.industry, "Tech")
        XCTAssertEqual(personas.first?.region, "US")
    }
}
