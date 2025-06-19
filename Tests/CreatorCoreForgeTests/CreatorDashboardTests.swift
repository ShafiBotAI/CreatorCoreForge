import XCTest
@testable import CreatorCoreForge

final class CreatorDashboardTests: XCTestCase {
    func testEnableAndDisableFeatures() {
        let suite = UserDefaults(suiteName: "CreatorDashboardTests")!
        let dashboard = CreatorDashboard(store: suite)
        dashboard.disable(.init(rawValue: Int.max))
        dashboard.enable([.voiceMemoryControl, .emotionGraphs])
        XCTAssertTrue(dashboard.isEnabled(.voiceMemoryControl))
        XCTAssertTrue(dashboard.isEnabled(.emotionGraphs))
        dashboard.disable(.voiceMemoryControl)
        XCTAssertFalse(dashboard.isEnabled(.voiceMemoryControl))
        XCTAssertTrue(dashboard.isEnabled(.emotionGraphs))
    }
}
