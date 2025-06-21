import XCTest
@testable import CreatorCoreForge

final class OnboardingManagerTests: XCTestCase {
    func testCompleteStep() {
        let suite = UserDefaults(suiteName: "OnboardingTest")!
        suite.removePersistentDomain(forName: "OnboardingTest")
        let manager = OnboardingManager(store: suite)
        XCTAssertFalse(manager.isCompleted(.welcome))
        manager.complete(.welcome)
        XCTAssertTrue(manager.isCompleted(.welcome))
        suite.removePersistentDomain(forName: "OnboardingTest")
    }
}
