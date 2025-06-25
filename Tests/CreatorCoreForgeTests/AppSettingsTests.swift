import XCTest
@testable import CreatorCoreForge

final class AppSettingsTests: XCTestCase {
    func testSaveAndLoad() {
        let suite = UserDefaults(suiteName: "AppSettingsTests")!
        suite.removePersistentDomain(forName: "AppSettingsTests")
        var settings = AppSettings(defaults: suite)
        XCTAssertFalse(settings.allowNSFW)
        settings.allowNSFW = true
        settings.offlineMode = true
        settings.performance = .cinematic
        settings.save()
        settings = AppSettings(defaults: suite)
        XCTAssertTrue(settings.allowNSFW)
        XCTAssertTrue(settings.offlineMode)
        XCTAssertEqual(settings.performance, .cinematic)
        suite.removePersistentDomain(forName: "AppSettingsTests")
    }
}
