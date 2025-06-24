import XCTest
@testable import CreatorCoreForge

final class BuildPreviewEngineTests: XCTestCase {
    func testStartPreviewAddsLog() {
        let engine = BuildPreviewEngine.shared
        _ = engine.startPreview(platform: "iOS")
        XCTAssertTrue(engine.currentLogs().contains { $0.contains("iOS") })
    }

    func testPerformanceMetricsContainsFPS() {
        let metrics = BuildPreviewEngine.shared.performanceMetrics()
        XCTAssertEqual(metrics["fps"], 60.0)
    }

    func testAddBreakpointAndInspectVariable() {
        let engine = BuildPreviewEngine.shared
        engine.addBreakpoint("load")
        engine.toggleDarkMode(enabled: true)
        XCTAssertEqual(engine.inspectVariable("darkMode") as? Bool, true)
        XCTAssertTrue(engine.currentLogs().contains { $0.contains("Breakpoint added") })
    }

    func testGenerateTestCases() {
        let cases = BuildPreviewEngine.shared.generateTestCases(from: ["login", "dashboard"])
        XCTAssertEqual(cases, ["test_login", "test_dashboard"])
    }
}
