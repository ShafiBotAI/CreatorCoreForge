import XCTest
@testable import CreatorCoreForge

final class BasicAuthServiceTests: XCTestCase {
    func testRegisterAutoSignsIn() {
        let service = BasicAuthService.shared
        service.register(email: "test@example.com", password: "pw", dob: Date())
        XCTAssertEqual(service.currentUser?.email, "test@example.com")
        XCTAssertTrue(service.signIn(email: "test@example.com", password: "pw"))
    }
}
