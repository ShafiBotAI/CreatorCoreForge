import XCTest
@testable import CreatorCoreForge

final class StealthVaultTests: XCTestCase {
    func testActivateWithCorrectPassword() {
        let vault = StealthVault()
        XCTAssertTrue(vault.activate(password: "secret123"))
    }

    func testActivateWithWrongPassword() {
        let vault = StealthVault()
        XCTAssertFalse(vault.activate(password: "wrong"))
    }
}
