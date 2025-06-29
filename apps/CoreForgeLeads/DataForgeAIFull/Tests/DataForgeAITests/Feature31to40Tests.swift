import XCTest
@testable import DataForgeAI

final class Feature31to40Tests: XCTestCase {
    func testOutreachAuditTool() {
        let tool = OutreachAuditTool()
        let result = tool.audit(messages: ["Great offer just for you"]) 
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result.values.first! > 0)
    }

    func testTeamDashboardLeaderboard() {
        let dash = TeamDashboard()
        dash.assignLead(to: "A")
        dash.assignLead(to: "B")
        dash.assignLead(to: "A")
        XCTAssertEqual(dash.leaderboard().first, "A")
    }

    func testComplianceLayer() {
        let lead = Lead(name: "Test", email: "t@e.com", company: "Co", industry: "Tech", region: "US")
        let compliance = ComplianceLayer()
        XCTAssertTrue(compliance.isCompliant(lead: lead, allowedRegions: ["US"]))
    }

    func testLeadLifecycleTracker() {
        let tracker = LeadLifecycleTracker()
        let lead = Lead(name: "Test", email: "t@e.com", company: "Co", industry: "Tech", region: "US")
        tracker.update(lead: lead, to: .engaged)
        XCTAssertEqual(tracker.stage(for: lead), .engaged)
    }
}
