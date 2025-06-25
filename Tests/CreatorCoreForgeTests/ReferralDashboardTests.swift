import XCTest
@testable import CreatorCoreForge

final class ReferralDashboardTests: XCTestCase {
    func testSummary() {
        let program = ReferralProgram()
        let code1 = program.createCode(for: "a")
        program.registerSignup(code: code1)
        let code2 = program.createCode(for: "b")
        program.registerSignup(code: code2)
        program.registerSignup(code: code2)
        let dashboard = ReferralDashboard()
        let summary = dashboard.summary(for: program)
        XCTAssertTrue(summary.contains(code1))
        XCTAssertTrue(summary.contains("1"))
        XCTAssertTrue(summary.contains(code2))
        XCTAssertTrue(summary.contains("2"))
        XCTAssertTrue(summary.contains("Terms:"))
    }
}
