import XCTest
@testable import CreatorCoreForge

final class NSFWSceneToggleTests: XCTestCase {
    func testAllowScene() {
        let toggle = NSFWSceneToggle(manager: NSFWContentManager())
        toggle.setEnabled(true, age: 20)
        XCTAssertTrue(toggle.allow(intensity: .softcore))
        toggle.setEnabled(false)
        XCTAssertFalse(toggle.allow(intensity: .softcore))
    }

    func testAgeVerification() {
        let toggle = NSFWSceneToggle(manager: NSFWContentManager())
        toggle.setEnabled(true, age: 15)
        XCTAssertFalse(toggle.allow(intensity: .softcore))
        toggle.setEnabled(true, age: 19)
        XCTAssertTrue(toggle.allow(intensity: .softcore))
    }
}
