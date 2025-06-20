import XCTest
@testable import CreatorCoreForge

final class AudioCreditManagerTests: XCTestCase {
    func testFreePlanCreditUsage() {
        let manager = CreditManager(plan: .free)
        XCTAssertTrue(manager.useCredit())
        for _ in 0..<9 { _ = manager.useCredit() }
        XCTAssertFalse(manager.hasCredits())
        manager.rechargeFreeCredits()
        XCTAssertEqual(manager.getRemainingCredits(), 10)
    }

    func testProPlanUnlimitedCredits() {
        let manager = CreditManager(plan: .pro)
        XCTAssertTrue(manager.useCredit())
        XCTAssertEqual(manager.getRemainingCredits(), -1)
        XCTAssertTrue(manager.hasCredits())
    }
}
