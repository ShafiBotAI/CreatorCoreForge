import XCTest
@testable import DataForgeAI

final class ProspectingWorkflowTests: XCTestCase {
    func testRunWorkflowReturnsTopLead() {
        let leads = [
            Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Software", region: "US"),
            Lead(name: "B", email: "b@b.com", company: "Beta", industry: "Retail", region: "EU")
        ]
        let workflow = ProspectingWorkflow()
        let top = workflow.run(leads: leads, limit: 1)
        XCTAssertEqual(top.count, 1)
        XCTAssertEqual(top.first?.lead.name, "A")
    }

    func testPersonalizedScripts() {
        let leads = [Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")]
        let workflow = ProspectingWorkflow()
        let scripts = workflow.personalizedScripts(for: leads, template: "Hi {name} from {company}")
        XCTAssertEqual(scripts, ["Hi A from Acme"])
    }
}
