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

    func testTrackPerformanceAndRetrieve() {
        let engine = BuildDeploymentEngine.shared
        engine.trackPerformance(for: "ios", metrics: ["fps": 60])
        XCTAssertEqual(engine.performance(for: "ios")?["fps"], 60)
    }

    func testPushHotfix() {
        let engine = BuildDeploymentEngine.shared
        XCTAssertTrue(engine.pushHotfix(platform: "web"))
    }

    func testValidateCompliance() {
        let engine = BuildDeploymentEngine.shared
        XCTAssertTrue(engine.validateCompliance(screenshots: true, privacyLabels: true))
    }

    func testRolloutStrategyLogged() {
        let engine = BuildDeploymentEngine.shared
        XCTAssertTrue(engine.rollout(strategy: "beta"))
        XCTAssertTrue(engine.history().contains { $0.contains("beta") })
    }
}
