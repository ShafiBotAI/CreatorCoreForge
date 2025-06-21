import XCTest
@testable import CreatorCoreForge

final class NSFWSFXPackManagerTests: XCTestCase {
    func testRegisterAndList() {
        let manager = NSFWSFXPackManager.shared
        manager.register(NSFWSFXPack(name: "Pack1", files: ["a", "b"]))
        XCTAssertEqual(manager.listPacks().count, 1)
        XCTAssertEqual(manager.files(for: "Pack1"), ["a", "b"])
    }
}
