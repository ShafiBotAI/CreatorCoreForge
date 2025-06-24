import XCTest
@testable import CreatorCoreForge

final class CrossAppModuleManagerTests: XCTestCase {
    func testRegisterAndRetrieve() {
        let manager = CrossAppModuleManager.shared
        manager.register("test", named: "string")
        let value: String? = manager.module(named: "string")
        XCTAssertEqual(value, "test")
    }
}
