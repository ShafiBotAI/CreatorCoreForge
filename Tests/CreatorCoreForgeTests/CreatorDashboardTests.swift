import XCTest
@testable import CreatorCoreForge

final class CreatorDashboardTests: XCTestCase {
    func testEnableAndDisableFeatures() {
        let suite = UserDefaults(suiteName: "CreatorDashboardTests")!
        let dashboard = CreatorDashboard(store: suite)
        dashboard.disable(.init(rawValue: Int.max))
        dashboard.enable([.voiceMemoryControl, .emotionGraphs, .sandboxTools])
        XCTAssertTrue(dashboard.isEnabled(.voiceMemoryControl))
        XCTAssertTrue(dashboard.isEnabled(.emotionGraphs))
        XCTAssertTrue(dashboard.isEnabled(.sandboxTools))
        dashboard.disable(.voiceMemoryControl)
        XCTAssertFalse(dashboard.isEnabled(.voiceMemoryControl))
        XCTAssertTrue(dashboard.isEnabled(.emotionGraphs))
        XCTAssertTrue(dashboard.isEnabled(.sandboxTools))
    }

    func testEnableAllIncludesNewToggles() {
        let suite = UserDefaults(suiteName: "CreatorDashboardEnableAll")!
        let dashboard = CreatorDashboard(store: suite)
        dashboard.enableAll()
        XCTAssertTrue(dashboard.isEnabled(.globalUnlock))
        XCTAssertTrue(dashboard.isEnabled(.sandboxTools))
    }
}
