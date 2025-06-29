import XCTest
@testable import CoreForgeAudioApp

final class SocialLoginTests: XCTestCase {
    func testGoogleLoginSetsEmail() {
        let manager = AuthManager.shared
        manager.signOut()
        let exp = expectation(description: "google")
        manager.signInWithGoogle(email: "g@test.com") { result in
            switch result {
            case .success:
                XCTAssertEqual(manager.email, "g@test.com")
            default:
                XCTFail("Failed")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testAppleLoginSetsEmail() {
        let manager = AuthManager.shared
        manager.signOut()
        let exp = expectation(description: "apple")
        manager.signInWithApple(email: "a@test.com") { result in
            switch result {
            case .success:
                XCTAssertEqual(manager.email, "a@test.com")
            default:
                XCTFail("Failed")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
