import XCTest
@testable import CreatorCoreForge

final class NSFWBlurToggleTests: XCTestCase {
    func testBlurToggleAgeGated() {
        let suite = UserDefaults(suiteName: "BlurToggleTests")!
        suite.removePersistentDomain(forName: "BlurToggleTests")
        var blur = NSFWBlurToggle(store: suite)
        var comps = DateComponents(); comps.year = Calendar.current.component(.year, from: Date()) - 10; comps.month = 1; comps.day = 1
        let underage = Calendar.current.date(from: comps)!
        XCTAssertFalse(blur.toggle(birthdate: underage))
        comps.year = Calendar.current.component(.year, from: Date()) - 20
        let adult = Calendar.current.date(from: comps)!
        XCTAssertTrue(blur.toggle(birthdate: adult))
        XCTAssertFalse(blur.isBlurred)
        XCTAssertTrue(blur.toggle(birthdate: adult))
        XCTAssertTrue(blur.isBlurred)
        suite.removePersistentDomain(forName: "BlurToggleTests")
    }
}
