import XCTest
@testable import CreatorCoreForge

final class HeatmapAnalyticsTests: XCTestCase {
    func testAverageAndMaxChapter() {
        let analytics = HeatmapAnalytics()
        analytics.log(chapter: 1, intensity: 0.1)
        analytics.log(chapter: 2, intensity: 0.6)
        analytics.log(chapter: 3, intensity: 0.3)
        XCTAssertEqual(analytics.averageIntensity(), 0.3333333333333333, accuracy: 0.0001)
        XCTAssertEqual(analytics.maxIntensityChapter(), 2)
        analytics.reset()
        XCTAssertEqual(analytics.averageIntensity(), 0.0, accuracy: 0.0001)
        XCTAssertNil(analytics.maxIntensityChapter())
    }
}
