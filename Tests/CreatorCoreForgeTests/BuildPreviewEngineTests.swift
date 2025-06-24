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
}
