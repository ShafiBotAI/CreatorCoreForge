import XCTest
@testable import CreatorCoreForge

final class NSFWSceneToggleTests: XCTestCase {
    func testAllowScene() {
        let toggle = NSFWSceneToggle(manager: NSFWContentManager())
        toggle.setEnabled(true)
        XCTAssertTrue(toggle.allow(intensity: .softcore))
        toggle.setEnabled(false)
        XCTAssertFalse(toggle.allow(intensity: .softcore))
    }
}
