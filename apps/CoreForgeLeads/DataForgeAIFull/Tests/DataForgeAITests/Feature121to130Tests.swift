import XCTest
@testable import DataForgeAI

final class Feature121to130Tests: XCTestCase {
    func testMonetizationDashboard() {
        var dash = MonetizationDashboard()
        dash.recordSale(packs: 2, pricePerPack: 5)
        dash.recordSale(packs: 1, pricePerPack: 10)
        XCTAssertEqual(dash.leadPacksSold, 3)
        XCTAssertEqual(dash.revenue, 20)
        XCTAssertEqual(dash.averageRevenuePerPack(), 20.0 / 3.0, accuracy: 0.001)
    }

    func testAffiliateMarketplace() {
        let market = AffiliateMarketplace()
        market.registerAffiliate(id: "A1", commissionRate: 0.1)
        market.recordSale(affiliateId: "A1")
        let payout = market.payout(for: "A1", pricePerSale: 100)
        XCTAssertEqual(payout, 10)
    }

    func testGamifiedLeadTool() {
        let tool = GamifiedLeadTool(prizes: ["Prize"])
        XCTAssertEqual(tool.spinWheel(), "Prize")
    }

    func testEmailHeatmapAnalyzer() {
        let analyzer = EmailHeatmapAnalyzer()
        let rate = analyzer.engagementRate(for: .init(opens: 100, clicks: 25))
        XCTAssertEqual(rate, 0.25, accuracy: 0.001)
    }

    func testCampaignROIPredictor() {
        let predictor = CampaignROIPredictor()
        let roi = predictor.roi(revenue: 200, cost: 100)
        XCTAssertEqual(roi, 100)
    }

    func testSEOSignalDetector() {
        let detector = SEOSignalDetector()
        let keywords = detector.topKeywords(in: "Swift swift swift coding best coding swift")
        XCTAssertEqual(keywords.first, "swift")
    }

    func testLeadDNAProfileBuilder() {
        let leads = [Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US"),
                      Lead(name: "B", email: "b@b.com", company: "Acme", industry: "Tech", region: "US"),
                      Lead(name: "C", email: "c@c.com", company: "Acme", industry: "Retail", region: "EU")]
        let builder = LeadDNAProfileBuilder()
        let profile = builder.build(from: leads)
        XCTAssertEqual(profile.commonIndustry, "Tech")
        XCTAssertEqual(profile.commonRegion, "US")
    }

    func testVoiceOutreachIntegrator() {
        let lead = Lead(name: "Test", email: "t@test.com", company: "Acme", industry: "Tech", region: "US")
        let integrator = VoiceOutreachIntegrator()
        let message = integrator.generateVoiceMessage(for: lead)
        XCTAssertTrue(message.contains("Test"))
    }

    func testLeadFormClassifier() {
        let classifier = LeadFormClassifier()
        XCTAssertEqual(classifier.classify(fields: ["Name", "Message"]), .contact)
        XCTAssertEqual(classifier.classify(fields: ["Email", "Password", "Confirm Password"]), .signup)
        XCTAssertEqual(classifier.classify(fields: ["Field1", "Field2"]), .unknown)
    }

    func testLeadPrioritizer() {
        let lead1 = PrioritizedLead(lead: Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US"), urgency: 5, stage: .warm)
        let lead2 = PrioritizedLead(lead: Lead(name: "B", email: "b@b.com", company: "Acme", industry: "Tech", region: "US"), urgency: 8, stage: .cold)
        let lead3 = PrioritizedLead(lead: Lead(name: "C", email: "c@c.com", company: "Acme", industry: "Tech", region: "US"), urgency: 3, stage: .hot)
        let prioritized = LeadPrioritizer().prioritize([lead1, lead2, lead3])
        XCTAssertEqual(prioritized.first?.lead.name, "C")
    }
}
