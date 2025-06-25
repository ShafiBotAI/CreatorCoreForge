import XCTest
@testable import CreatorCoreForge

final class ExportManagerTests: XCTestCase {
    func testExportAndValidate() {
        let manager = ExportManager()
        let path = manager.export(platform: "ios", output: "/tmp")
        XCTAssertTrue(manager.validate(path: path))
    }

    func testDetectBlockers() {
        let manager = ExportManager()
        let none = manager.detectBlockers(projectFiles: ["LoginScreen", "icon.png", "validation.js"])
        XCTAssertEqual(none.isEmpty, true)
        let issues = manager.detectBlockers(projectFiles: ["Main"])
        XCTAssertTrue(issues.contains("missing login screen"))
        XCTAssertTrue(issues.contains("missing app icon"))
        XCTAssertTrue(issues.contains("no validation logic found"))
    }
}
