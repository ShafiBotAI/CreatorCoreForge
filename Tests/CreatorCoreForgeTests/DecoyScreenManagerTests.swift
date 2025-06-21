import XCTest
@testable import CreatorCoreForge

final class DecoyScreenManagerTests: XCTestCase {
    func testEnableDisable() {
        let manager = DecoyScreenManager.shared
        manager.disable()
        XCTAssertFalse(manager.isActive())
        manager.enable()
        XCTAssertTrue(manager.isActive())
        manager.disable()
        XCTAssertFalse(manager.isActive())
    }
}
