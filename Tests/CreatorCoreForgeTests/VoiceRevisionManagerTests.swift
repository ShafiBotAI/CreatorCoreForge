import XCTest
@testable import CreatorCoreForge

final class VoiceRevisionManagerTests: XCTestCase {
    func testFreeRevisionsLimit() {
        let suite = UserDefaults(suiteName: "VRMFree")!
        suite.removePersistentDomain(forName: "VRMFree")
        let manager = VoiceRevisionManager(defaults: suite)
        let id = "book1"
        for _ in 0..<5 {
            XCTAssertTrue(manager.canRevise(bookID: id))
            manager.recordRevision(bookID: id)
        }
        XCTAssertFalse(manager.canRevise(bookID: id))
        XCTAssertTrue(manager.requiresCredit(bookID: id))
        suite.removePersistentDomain(forName: "VRMFree")
    }

    func testRevisionResetAfterThirtyDays() {
        let suite = UserDefaults(suiteName: "VRMReset")!
        let id = "book2"
        let dateKey = "VRM_Date_" + id
        let countKey = "VRM_Count_" + id
        suite.set(Date(timeIntervalSinceNow: -60*60*24*31), forKey: dateKey)
        suite.set(4, forKey: countKey)
        let manager = VoiceRevisionManager(defaults: suite)
        XCTAssertTrue(manager.canRevise(bookID: id))
        XCTAssertEqual(suite.integer(forKey: countKey), 0)
        suite.removePersistentDomain(forName: "VRMReset")
    }
}
