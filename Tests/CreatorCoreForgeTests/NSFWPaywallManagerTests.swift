import XCTest
@testable import CreatorCoreForge

final class NSFWPaywallManagerTests: XCTestCase {
    func testUnlockAndTip() {
        let manager = NSFWPaywallManager.shared
        XCTAssertFalse(manager.isPremiumUnlocked())
        XCTAssertFalse(manager.unlockPremium(code: "wrong"))
        XCTAssertFalse(manager.isPremiumUnlocked())
        XCTAssertTrue(manager.unlockPremium(code: "UNLOCK-NSFW"))
        XCTAssertTrue(manager.isPremiumUnlocked())
        manager.addTip(1.5)
        manager.addTip(2.0)
        XCTAssertEqual(manager.totalTips, 3.5)
    }
}
