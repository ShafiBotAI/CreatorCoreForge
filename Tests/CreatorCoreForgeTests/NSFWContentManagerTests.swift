import XCTest
@testable import CreatorCoreForge

final class NSFWContentManagerTests: XCTestCase {
    func testUnlockWithPromoCode() {
        let manager = NSFWContentManager.shared
        manager.unlocked = false
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
}
