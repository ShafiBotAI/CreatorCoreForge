import XCTest
@testable import CreatorCoreForge

final class SubscriptionCreditSystemTests: XCTestCase {
    func testPageConsumptionAndReset() {
        let suite = UserDefaults(suiteName: "SubCredits")!
        var system = SubscriptionCreditSystem(monthlyPages: 10, monthlyBooks: 2, userDefaults: suite)
        XCTAssertTrue(system.consumePages(5))
        XCTAssertFalse(system.consumePages(6))
        system.addPageCredits(3)
        XCTAssertTrue(system.consumePages(6))
        // simulate new month
        suite.set("2000-1", forKey: "SCS_Month")
        system = SubscriptionCreditSystem(monthlyPages: 10, monthlyBooks: 2, userDefaults: suite)
        XCTAssertEqual(system.remainingPages, 10)
        suite.removePersistentDomain(forName: "SubCredits")
    }
}
