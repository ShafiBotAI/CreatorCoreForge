import XCTest
@testable import CoreForgeAudioApp

final class ReferralManagerTests: XCTestCase {
    func testRewardsAccumulate() {
        let suite = UserDefaults(suiteName: "ReferralTests")!
        suite.removePersistentDomain(forName: "ReferralTests")
        let manager = ReferralManager(userDefaults: suite)
        let code = manager.myCode()
        manager.referralCode = code
        manager.rewardReferrer(for: .creator)
        XCTAssertEqual(manager.credits(for: code), 15)
        manager.rewardReferrer(for: .author)
        XCTAssertEqual(manager.credits(for: code), 45)
        suite.removePersistentDomain(forName: "ReferralTests")
    }
}
