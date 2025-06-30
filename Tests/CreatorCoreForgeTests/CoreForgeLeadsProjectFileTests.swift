import XCTest

final class CoreForgeLeadsProjectFileTests: XCTestCase {
    func testProjectFileContainsTarget() throws {
        let path = "apps/CoreForgeLeads/CoreForgeLeads.xcodeproj/project.pbxproj"
        let content = try String(contentsOfFile: path)
        XCTAssertTrue(content.contains("CoreForgeLeads"), "project file missing target name")
        XCTAssertTrue(content.contains("PBXBuildFile"), "project file missing build entries")
    }
}
