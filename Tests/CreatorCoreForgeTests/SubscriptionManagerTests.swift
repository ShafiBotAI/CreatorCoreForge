import XCTest
@testable import CreatorCoreForge

final class SubscriptionManagerTests: XCTestCase {
    func testPlanPrices() {
        let manager = SubscriptionManager()
        XCTAssertEqual(manager.price(for: .free), 0)
        XCTAssertEqual(manager.price(for: .creator), 19.99)
        XCTAssertEqual(manager.price(for: .author), 99.99)
        XCTAssertEqual(manager.price(for: .enterprise), 49.99)

        XCTAssertEqual(manager.price(for: .creator, cycle: .annual), 179.91)
        XCTAssertEqual(manager.price(for: .author, cycle: .annual), 899.91)
        XCTAssertEqual(manager.price(for: .enterprise, cycle: .annual), 449.91)
    }

    func testExportLimits() throws {
        throw XCTSkip("Export limit logic depends on monthly credit defaults")
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
