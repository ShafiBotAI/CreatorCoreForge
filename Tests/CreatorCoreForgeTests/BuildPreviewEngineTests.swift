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

    func testSelectDeviceAndRenderFrame() {
        let engine = BuildPreviewEngine.shared
        engine.selectDevice(.android)
        let frame = engine.renderFrame()
        XCTAssertTrue(frame.contains("android"))
    }

    func testSimulateErrorRecorded() {
        let engine = BuildPreviewEngine.shared
        engine.simulateError("network")
        XCTAssertEqual(engine.inspectVariable("error") as? String, "network")
    }

    func testRunWebTestsReturnsResults() {
        let engine = BuildPreviewEngine.shared
        let results = engine.runWebTests(runner: "jest", cases: ["a", "b"])
        XCTAssertEqual(results, ["a": true, "b": true])
    }
}
