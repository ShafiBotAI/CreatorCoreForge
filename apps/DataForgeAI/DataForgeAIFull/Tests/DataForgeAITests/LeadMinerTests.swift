import XCTest
@testable import DataForgeAI

final class LeadMinerTests: XCTestCase {
    func testPersonalizeScript() {
        let lead = Lead(name: "Alice", email: "a@example.com", company: "Acme", industry: "Software", region: "US")
        let miner = LeadMiner()
        let result = miner.autoPersonalizeScript(for: lead, template: "Hi {name} from {company}")
        XCTAssertEqual(result, "Hi Alice from Acme")
    }
}
