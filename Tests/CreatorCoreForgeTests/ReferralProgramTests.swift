import XCTest
@testable import CreatorCoreForge

final class ReferralProgramTests: XCTestCase {
    func testCreateCodeAndRegister() {
        let program = ReferralProgram()
        let code = program.createCode(for: "user@example.com")
        XCTAssertEqual(code.count, 8)
        XCTAssertEqual(program.signups(for: code), 0)
        program.registerSignup(code: code)
        XCTAssertEqual(program.signups(for: code), 1)
    }

    func testUpdateTerms() {
        let program = ReferralProgram()
        program.updateTerms("New terms")
        XCTAssertEqual(program.currentInfo().terms, "New terms")
    }

    func testPerAppTerms() {
        let program = ReferralProgram()
        program.updateTerms("App A terms", forApp: "AppA")
        XCTAssertEqual(program.currentInfo(forApp: "AppA").terms, "App A terms")
        // Default terms should remain unchanged
        XCTAssertEqual(program.currentInfo().terms, "Standard referral rewards apply.")
    }
}
