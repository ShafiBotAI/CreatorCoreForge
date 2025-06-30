import XCTest
@testable import CreatorCoreForge

final class NSFWContentManagerTests: XCTestCase {
    func testSceneAllowedLogic() {
        let manager = NSFWContentManager.shared
        manager.ageVerified = true
        manager.unlock(with: "creatoraccess")
        manager.setIntensity(level: .rough)
        manager.setViewerFilter(enabled: false)
        XCTAssertTrue(manager.isSceneAllowed(.softcore))
        XCTAssertFalse(manager.isSceneAllowed(.hardcore))
    }
}
