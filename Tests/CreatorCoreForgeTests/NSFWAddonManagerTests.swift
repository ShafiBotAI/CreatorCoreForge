import XCTest
@testable import CreatorCoreForge

final class NSFWAddonManagerTests: XCTestCase {
    func testPurchaseUnlocksFlag() {
        let defaults = UserDefaults(suiteName: "AddonTest")!
        defaults.removePersistentDomain(forName: "AddonTest")
        let manager = NSFWAddonManager(userDefaults: defaults)
        manager.purchase { success in
            XCTAssertTrue(success)
            XCTAssertTrue(manager.isUnlocked)
        }
        defaults.removePersistentDomain(forName: "AddonTest")
    }
}
