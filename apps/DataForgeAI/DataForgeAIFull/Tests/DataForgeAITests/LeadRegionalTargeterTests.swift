import XCTest
@testable import DataForgeAI

final class LeadRegionalTargeterTests: XCTestCase {
    func testFilterByRegion() {
        let leads = [
            Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US"),
            Lead(name: "B", email: "b@b.com", company: "Beta", industry: "Retail", region: "EU"),
            Lead(name: "C", email: "c@c.com", company: "Gamma", industry: "Tech", region: "US")
        ]
        let targeter = LeadRegionalTargeter()
        let filtered = targeter.filter(leads: leads, region: "US")
        XCTAssertEqual(filtered.count, 2)
    }

    func testLocalizedGreeting() {
        let targeter = LeadRegionalTargeter()
        XCTAssertEqual(targeter.localizedGreeting(language: "es"), "Hola")
        XCTAssertEqual(targeter.localizedGreeting(language: "fr"), "Bonjour")
        XCTAssertEqual(targeter.localizedGreeting(language: "unknown"), "Hello")
    }
}
