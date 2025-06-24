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

    func testGenerateBuilds() {
        let builds = BuildDeploymentEngine.shared.generateBuilds(for: ["ios", "android"])
        XCTAssertEqual(builds.count, 2)
    }

    func testOneClickDeployLogsHistory() {
        let engine = BuildDeploymentEngine.shared
        _ = engine.oneClickDeploy(platform: "ios", destination: "App Store")
        XCTAssertTrue(engine.history().contains { $0.contains("App Store") })
    }
}
