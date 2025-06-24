import XCTest
@testable import CreatorCoreForge

final class ConsentTrackerTests: XCTestCase {
    func testConsentLogging() {
        let tracker = ConsentTracker()
        tracker.logConsent(userID: "user", consent: true)
        XCTAssertEqual(tracker.events.count, 1)
        XCTAssertTrue(tracker.events.first?.consentGiven ?? false)
    }

    func testSafeWordDetection() {
        let tracker = ConsentTracker()
        tracker.safeWord = "pineapple"
        XCTAssertTrue(tracker.containsSafeWord("PINEAPPLE please"))
        XCTAssertFalse(tracker.containsSafeWord("nothing here"))
    }
}
