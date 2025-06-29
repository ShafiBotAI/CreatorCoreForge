import XCTest
@testable import DataForgeAI

final class Feature11to20Tests: XCTestCase {
    func testChromeScraperFindsEmails() {
        let scraper = ChromeLeadScraper()
        let emails = scraper.scrapeEmails(from: "Contact us at test@example.com")
        XCTAssertEqual(emails.first, "test@example.com")
    }

    func testLinkedInMessageTone() {
        let assistant = LinkedInMessageAssistant()
        let lead = Lead(name: "Bob", email: "b@b.com", company: "Beta", industry: "Tech", region: "US")
        XCTAssertTrue(assistant.craftMessage(to: lead, tone: "casual").contains(":)"))
    }

    func testContactVerifier() {
        let verifier = ContactVerifier()
        XCTAssertEqual(verifier.bounceRisk(for: "bad"), 1.0)
        XCTAssertEqual(verifier.bounceRisk(for: "good@example.com"), 0.0)
    }

    func testVoiceOutreachScript() {
        let assistant = VoiceOutreachAssistant()
        let lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        XCTAssertTrue(assistant.script(for: lead, mood: "friendly").contains("Acme"))
    }

    func testABMPlaybook() {
        let generator = ABMPlaybookGenerator()
        XCTAssertTrue(generator.generate(for: "SaaS").count > 1)
    }

    func testLandingPageGenerator() {
        let generator = LandingPageGenerator()
        let html = generator.generateHTML(for: "SaaS")
        XCTAssertTrue(html.contains("SaaS"))
    }

    func testABTestGenerator() {
        let generator = ABTestGenerator()
        let variants = generator.generateVariants(base: "Great offer")
        XCTAssertEqual(variants.count, 2)
    }

    func testLeadVideoPersonalizer() {
        let lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        let url = LeadVideoPersonalizer().createVideo(for: lead)
        XCTAssertTrue(url.path.contains("A_video"))
    }

    func testAutonomousLeadAgent() {
        let lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        XCTAssertTrue(AutonomousLeadAgent(lead: lead).qualify())
    }

    func testTimezoneScheduler() {
        let lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "UTC")
        let scheduler = TimezoneScheduler()
        XCTAssertNotNil(scheduler.localSendTime(for: lead, hour: 10))
    }
}
