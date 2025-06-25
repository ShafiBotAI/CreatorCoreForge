import XCTest
@testable import CreatorCoreForge

final class NSFWContentManagerTests: XCTestCase {
    func testUnlockWithPromoCode() {
        let manager = NSFWContentManager.shared
        manager.unlocked = false
        manager.verifyAge(20)
        manager.unlock(with: "creatoraccess")
        XCTAssertTrue(manager.unlocked)
    }

    func testSceneLoggingAndFiltering() {
        let manager = NSFWContentManager.shared
        manager.clearSceneLog()
        manager.logScene(chapter: "1", label: "test1", intensity: .softcore)
        manager.logScene(chapter: "1", label: "test2", intensity: .hardcore)
        XCTAssertEqual(manager.getRecentScenes().count, 2)
        let hardcore = manager.filterScenes(by: .hardcore)
        XCTAssertEqual(hardcore.count, 1)
    }

    func testSceneAllowed() {
        let manager = NSFWContentManager.shared
        manager.unlocked = true
        manager.setIntensity(level: .sensual)
        XCTAssertTrue(manager.isSceneAllowed(.softcore))
        XCTAssertFalse(manager.isSceneAllowed(.hardcore))
    }

    func testModeSetting() {
        let manager = NSFWContentManager.shared
        manager.setMode(.medium)
        XCTAssertEqual(manager.contentMode, .medium)
    }

    func testConsentAndPause() {
        let manager = NSFWContentManager.shared
        manager.logConsent(userID: "u1", consent: true)
        XCTAssertNotNil(ConsentTracker.shared.lastConsent(for: "u1"))
        ConsentTracker.shared.safeWord = "pause"
        XCTAssertTrue(manager.shouldPause(for: "please PAUSE now"))
    }

    func testAftercarePrompt() {
        let manager = NSFWContentManager.shared
        let first = manager.nextAftercarePrompt()
        let second = manager.nextAftercarePrompt()
        XCTAssertNotEqual(first, "")
        XCTAssertNotEqual(second, "")
    }

    func testAgeVerification() {
        let manager = NSFWContentManager.shared
        manager.verifyAge(16)
        XCTAssertFalse(manager.ageVerified)
        manager.verifyAge(18)
        XCTAssertTrue(manager.ageVerified)
    }
}
