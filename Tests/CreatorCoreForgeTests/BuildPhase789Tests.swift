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

    func testProjectSharingInvitesAndExpiration() {
        var manager = ProjectSharingManager()
        manager.invite(Collaborator(userID: "dev", role: .developer))
        manager.invite(Collaborator(userID: "guest", role: .guest, expires: Date(timeIntervalSinceNow: -10)))
        XCTAssertEqual(manager.activeCollaborators().count, 1)
    }

    func testAICoPilotRedundancy() {
        let code = "print(1)\nprint(1)"
        let copilot = AICoPilot()
        let dups = copilot.highlightRedundancy(in: code)
        XCTAssertTrue(dups.contains("print(1)"))
    }

    func testSecurityScanner() {
        let scanner = SecurityScanner()
        XCTAssertFalse(scanner.scan(code: "eval('hack')"))
        XCTAssertTrue(scanner.scan(code: "print('safe')"))
    }
}
