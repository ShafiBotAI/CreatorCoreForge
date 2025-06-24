import XCTest
@testable import VocalVision

final class UploadLimiterTests: XCTestCase {
    func testSinglePlatformRestriction() {
        let limiter = UploadLimiter()
        XCTAssertTrue(limiter.canUpload(to: "YouTube"))
        XCTAssertFalse(limiter.canUpload(to: "TikTok"))
    }

    func testUnlockingAllPlatforms() {
        let limiter = UploadLimiter()
        _ = limiter.canUpload(to: "YouTube")
        XCTAssertFalse(limiter.canUpload(to: "TikTok"))
        limiter.unlockAllPlatforms()
        XCTAssertTrue(limiter.canUpload(to: "TikTok"))
    }
}
