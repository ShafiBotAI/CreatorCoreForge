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
}
