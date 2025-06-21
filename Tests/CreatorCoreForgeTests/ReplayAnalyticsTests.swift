import XCTest
@testable import CreatorCoreForge

final class ReplayAnalyticsTests: XCTestCase {
    func testRecordingStats() {
        let analytics = ReplayAnalytics()
        analytics.recordReplay(for: "line1")
        analytics.recordReplay(for: "line1")
        analytics.recordSkip(for: "line1")
        analytics.recordLoop(for: "line1")
        let stats = analytics.stats(for: "line1")
        XCTAssertEqual(stats.replays, 2)
        XCTAssertEqual(stats.skips, 1)
        XCTAssertEqual(stats.loops, 1)
    }

    func testResetClearsStats() {
        let analytics = ReplayAnalytics()
        analytics.recordReplay(for: "line2")
        analytics.reset()
        let stats = analytics.stats(for: "line2")
        XCTAssertEqual(stats.replays, 0)
        XCTAssertEqual(stats.skips, 0)
        XCTAssertEqual(stats.loops, 0)
    }
}
