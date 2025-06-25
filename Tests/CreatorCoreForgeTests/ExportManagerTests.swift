import XCTest
@testable import CreatorCoreForge

final class ExportManagerTests: XCTestCase {
    func testExportAndValidate() {
        let manager = ExportManager()
        let path = manager.export(platform: "ios", output: "/tmp")
        XCTAssertTrue(manager.validate(path: path))
    }
}
