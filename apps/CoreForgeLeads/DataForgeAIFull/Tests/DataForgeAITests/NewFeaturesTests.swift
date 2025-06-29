import XCTest
@testable import DataForgeAI

final class NewFeaturesTests: XCTestCase {
    func testPredictiveScore() {
        var lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Software", region: "US")
        lead.firmographics["size"] = "200"
        let scorer = AIAgentScoring()
        let score = scorer.predictiveScore(for: lead, behaviorSignals: ["clicks": 5])
        XCTAssertTrue(score > 50)
    }

    func testICPBuilder() {
        let leads = [
            Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US"),
            Lead(name: "B", email: "b@b.com", company: "Beta", industry: "Tech", region: "US"),
            Lead(name: "C", email: "c@c.com", company: "Gamma", industry: "Retail", region: "EU")
        ]
        let builder = ICPBuilder()
        let icp = builder.buildICP(from: leads)
        XCTAssertEqual(icp?.industry, "Tech")
        XCTAssertEqual(icp?.region, "US")
    }

    func testFollowUpEngine() {
        let engine = FollowUpEngine()
        let lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        engine.schedule(lead: lead, channel: .sms, at: Date(timeIntervalSinceNow: -60))
        let due = engine.dueFollowUps()
        XCTAssertEqual(due.count, 1)
        XCTAssertEqual(due.first?.1, .sms)
    }
}
