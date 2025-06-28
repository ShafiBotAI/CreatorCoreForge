import XCTest
@testable import CreatorCoreForge

final class SubscriptionManagerTests: XCTestCase {
    func testPlanPrices() {
        let manager = SubscriptionManager()
        XCTAssertEqual(manager.price(for: .free), 0)
        XCTAssertEqual(manager.price(for: .creator), 9.99)
        XCTAssertEqual(manager.price(for: .author), 14.99)
        XCTAssertEqual(manager.price(for: .enterprise), 29.99)
    }

    func testExportLimits() {
        let suite = UserDefaults(suiteName: "SubMgr")!
        var manager = SubscriptionManager(plan: .free, userDefaults: suite)
        for _ in 0..<5 { manager.recordExport() }
        XCTAssertFalse(manager.canExport())
        manager.upgrade(to: .creator)
        XCTAssertTrue(manager.canExport())
        manager.upgrade(to: .author)
        XCTAssertTrue(manager.canExport())
        suite.removePersistentDomain(forName: "SubMgr")
    }

    func testNSFWUnlock() {
        let suite = UserDefaults(suiteName: "SubMgrNSFW")!
        var manager = SubscriptionManager(plan: .creator, userDefaults: suite)
        XCTAssertFalse(manager.isNSFWUnlocked)
        manager.unlockNSFW()
        XCTAssertTrue(manager.isNSFWUnlocked)
        manager.upgrade(to: .enterprise)
        XCTAssertTrue(manager.isNSFWUnlocked)
        suite.removePersistentDomain(forName: "SubMgrNSFW")
    }
}
