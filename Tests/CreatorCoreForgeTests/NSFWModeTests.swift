import XCTest
@testable import CreatorCoreForge

final class NSFWModeTests: XCTestCase {
    func testEnableAndDisableFlow() {
        let suite = UserDefaults(suiteName: "NSFWModeTests")!
        suite.removePersistentDomain(forName: "NSFWModeTests")
        let settings = AppSettings(defaults: suite)
        let verifier = AgeIDVerifier(store: suite)
        let mode = NSFWMode(settings: settings, verifier: verifier)

        XCTAssertFalse(mode.isEnabled)
        XCTAssertTrue(mode.enable(birthdate: Date(timeIntervalSince1970: 0), idNumber: "123456"))
        XCTAssertTrue(mode.isEnabled)

        mode.disable()
        XCTAssertFalse(mode.isEnabled)
    }
}
