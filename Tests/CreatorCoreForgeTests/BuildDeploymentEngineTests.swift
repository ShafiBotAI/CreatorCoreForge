import XCTest
@testable import CreatorCoreForge

final class BuildDeploymentEngineTests: XCTestCase {
    func testExportBuildReturnsDistPath() {
        let path = BuildDeploymentEngine.shared.exportBuild(platform: "android")
        XCTAssertTrue(path.contains("dist"))
    }

    func testValidatePermissions() {
        XCTAssertTrue(BuildDeploymentEngine.shared.validatePermissions(for: "ios"))
    }
}
