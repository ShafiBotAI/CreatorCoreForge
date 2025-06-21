import XCTest
@testable import CreatorCoreForge

final class VisualFeatureStubsTests: XCTestCase {
    func testWatermarkService() {
        let svc = WatermarkService()
        XCTAssertEqual(svc.applyWatermark(frame: "frame1", watermark: "wm"), "frame1-wm(wm)")
    }

    func testFaceTrackerService() {
        let tracker = FaceTrackerService()
        XCTAssertTrue(tracker.track(frame: Data()).isEmpty)
    }

    func testSubtitleGenerator() {
        let subs = generateSubtitles(from: "Hello\nWorld")
        XCTAssertEqual(subs.count, 2)
        XCTAssertEqual(subs.first?.text, "Hello")
    }

    func testRenderAnalyticsDashboard() {
        let dash = RenderAnalyticsDashboard()
        let output = dash.display(metrics: [RenderMetric(name: "fps", value: 60)])
        XCTAssertTrue(output.contains("fps"))
    }
}
