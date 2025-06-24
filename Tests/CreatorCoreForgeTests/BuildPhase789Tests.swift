import XCTest
@testable import CreatorCoreForge

final class BuildPhase789Tests: XCTestCase {
    func testAuditTrailRecordsEvents() {
        let trail = AuditTrail()
        trail.record(userID: "user1", action: "create")
        XCTAssertEqual(trail.history().count, 1)
        XCTAssertEqual(trail.history().first?.userID, "user1")
    }
    
    func testAICoPilotSuggestsTodo() {
        let copilot = AICoPilot()
        let suggestion = copilot.suggestRefactor(for: "// TODO: refactor")
        XCTAssertTrue(suggestion.contains("TODO"))
    }
    
    func testComplianceCheckerDetectsDocs() {
        let checker = ComplianceChecker()
        let path = "apps/CoreForgeBuild/docs"
        XCTAssertTrue(checker.validatePrivacyDocs(at: path))
    }
}
