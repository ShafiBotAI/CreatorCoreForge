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

    func testProjectSharingRolePermissions() {
        var manager = ProjectSharingManager()
        manager.invite(Collaborator(userID: "admin", role: .admin))
        manager.invite(Collaborator(userID: "viewer", role: .viewer))
        manager.invite(Collaborator(userID: "commenter", role: .commenter))

        XCTAssertTrue(manager.canEdit(userID: "admin"))
        XCTAssertFalse(manager.canEdit(userID: "viewer"))
        XCTAssertTrue(manager.canView(userID: "viewer"))
        XCTAssertTrue(manager.canComment(userID: "commenter"))
    }

    func testProjectSharingPromoteAndAPIAudit() {
        var manager = ProjectSharingManager()
        manager.invite(Collaborator(userID: "dev", role: .developer))
        manager.promote(userID: "dev", to: .admin)
        manager.logAPIAccess(userID: "dev", endpoint: "/deploy")

        XCTAssertEqual(manager.role(for: "dev"), .admin)
        XCTAssertTrue(manager.history().contains { $0.action.contains("role:admin") })
        XCTAssertTrue(manager.history().contains { $0.action.contains("api:/deploy") })
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

    func testCopilotAutocompleteAndComplexity() {
        let copilot = AICoPilot()
        XCTAssertEqual(copilot.autocomplete(for: "func test", styleGuide: "Swift"), "func test {}")
        let big = Array(repeating: "line", count: 60).joined(separator: "\n")
        XCTAssertFalse(copilot.complexityWarnings(in: big).isEmpty)
    }
}
