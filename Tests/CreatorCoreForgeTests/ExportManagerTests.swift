import XCTest
@testable import CreatorCoreForge

final class ExportManagerTests: XCTestCase {
    func testExportAndValidate() {
        let manager = ExportManager()
        let path = manager.export(platform: "ios", output: "/tmp")
        XCTAssertTrue(manager.validate(path: path))
    }

    func testDetectExportBlockers() {
        let manager = ExportManager()
        XCTAssertEqual(manager.detectExportBlockers(screens: 0, logicValid: false).count, 2)
        XCTAssertEqual(manager.detectExportBlockers(screens: 1, logicValid: true), [])
    }
}
