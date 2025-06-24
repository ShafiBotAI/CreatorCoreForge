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

    func testStatusAlertRecorded() {
        let engine = BuildDeploymentEngine.shared
        _ = engine.pushStatusAlert("Deployed")
        XCTAssertTrue(engine.alerts().contains("Deployed"))
    }

    func testCompressAssetsCreatesFiles() {
        let engine = BuildDeploymentEngine.shared
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent("asset.txt")
        try? "data".write(to: tmp, atomically: true, encoding: .utf8)
        let outputs = engine.compressAssets(at: [tmp.path])
        XCTAssertFalse(outputs.isEmpty)
        XCTAssertTrue(FileManager.default.fileExists(atPath: outputs[0]))
    }

    func testExportAllBuildsWritesFiles() {
        let engine = BuildDeploymentEngine.shared
        let distDir = URL(fileURLWithPath: "dist")
        try? FileManager.default.removeItem(at: distDir)
        XCTAssertTrue(engine.exportAllBuilds(platforms: ["ios"], changelog: "c", metadata: ["v": "1"]))
        XCTAssertTrue(FileManager.default.fileExists(atPath: distDir.appendingPathComponent("ios.build").path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: distDir.appendingPathComponent("metadata.json").path))
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

    func testNewDeploymentUtilities() {
        let engine = BuildDeploymentEngine.shared
        let profile = engine.aiPerformanceProfile(buildPath: "app")
        XCTAssertNotNil(profile["cpu"])
        XCTAssertTrue(engine.bundleSizeHints(for: ["lib"]).first?.contains("lib") ?? false)
        XCTAssertTrue(engine.generatePermissionsManifest(platform: "ios").contains("camera"))
        XCTAssertTrue(engine.verifyOfflineMode(path: "Package.swift"))
        XCTAssertGreaterThan(engine.recordFirstRender(startTime: 0, firstRender: 1), 0)
        XCTAssertTrue(engine.readyForStores())
        XCTAssertTrue(engine.securityBadge(partner: "abc").contains("abc"))
    }
}
