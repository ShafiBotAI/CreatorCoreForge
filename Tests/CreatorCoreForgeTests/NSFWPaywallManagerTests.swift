import XCTest
@testable import CreatorCoreForge

final class NSFWPaywallManagerTests: XCTestCase {
    func testPurchaseAndTip() {
        let manager = NSFWPaywallManager.shared
        XCTAssertFalse(manager.isPremiumUnlocked())
        XCTAssertTrue(manager.purchasePremium())
        XCTAssertTrue(manager.isPremiumUnlocked())
        manager.addTip(1.5)
        manager.addTip(2.0)
        XCTAssertEqual(manager.totalTips, 3.5)
    }
}
