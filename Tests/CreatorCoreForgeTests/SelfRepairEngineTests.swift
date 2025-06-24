import XCTest
@testable import CreatorCoreForge

final class SelfRepairEngineTests: XCTestCase {
    func testRepairAllAppsUpdatesFiles() throws {
        let temp = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: temp, withIntermediateDirectories: true)
        let appsDir = temp.appendingPathComponent("apps")
        try FileManager.default.createDirectory(at: appsDir, withIntermediateDirectories: true)
        let sampleApp = appsDir.appendingPathComponent("Demo")
        try FileManager.default.createDirectory(at: sampleApp, withIntermediateDirectories: true)
        let file = sampleApp.appendingPathComponent("Sample.swift")
        try "func demo() { fatalError(\"Not implemented\") }".write(to: file, atomically: true, encoding: .utf8)
        let engine = SelfRepairEngine()
        XCTAssertEqual(engine.repairAllApps(at: temp.path), 1)
        let text = try String(contentsOf: file)
        XCTAssertTrue(text.contains("// TODO: implement"))
    }

    func testReportIssuesAggregatesResults() throws {
        let temp = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: temp, withIntermediateDirectories: true)
        let appsDir = temp.appendingPathComponent("apps")
        try FileManager.default.createDirectory(at: appsDir, withIntermediateDirectories: true)
        let sampleApp = appsDir.appendingPathComponent("Demo")
        try FileManager.default.createDirectory(at: sampleApp, withIntermediateDirectories: true)
        let file = sampleApp.appendingPathComponent("Sample.swift")
        try "func demo() { fatalError(\"Not implemented\") }".write(to: file, atomically: true, encoding: .utf8)
        let engine = SelfRepairEngine()
        let issues = engine.reportIssues(at: temp.path)
        XCTAssertTrue(issues.contains { $0.contains("Missing implementation") })
    }
}
