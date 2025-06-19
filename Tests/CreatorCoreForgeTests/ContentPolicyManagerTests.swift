import XCTest
@testable import CreatorCoreForge

final class ContentPolicyManagerTests: XCTestCase {
    func testAllowedContent() {
        XCTAssertTrue(ContentPolicyManager.isAllowed(text: "hello world", nsfw: false))
    }

    func testBlockedContent() {
        XCTAssertFalse(ContentPolicyManager.isAllowed(text: "nsfw scene", nsfw: false))
    }

    func testSanitize() {
        let result = ContentPolicyManager.sanitize("This is nsfw content")
        XCTAssertFalse(result.lowercased().contains("nsfw"))
    }
}
