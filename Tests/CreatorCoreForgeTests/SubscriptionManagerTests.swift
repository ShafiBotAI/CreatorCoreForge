import XCTest
@testable import CreatorCoreForge

final class SubscriptionManagerTests: XCTestCase {
    func testPlanPrices() {
        let manager = SubscriptionManager()
        XCTAssertEqual(manager.price(for: .free), 0)
        XCTAssertEqual(manager.price(for: .creator), 9.99)
        XCTAssertEqual(manager.price(for: .enterprise), 29.99)
    }

    func testExportLimits() {
        let suite = UserDefaults(suiteName: "SubMgr")!
        var manager = SubscriptionManager(plan: .free, userDefaults: suite)
        for _ in 0..<5 { manager.recordExport() }
        XCTAssertFalse(manager.canExport())
        manager.upgrade(to: .creator)
        XCTAssertTrue(manager.canExport())
        suite.removePersistentDomain(forName: "SubMgr")
    }
}
