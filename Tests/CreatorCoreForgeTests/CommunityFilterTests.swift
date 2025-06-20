import XCTest
@testable import CreatorCoreForge

final class CommunityFilterTests: XCTestCase {
    func testPinToggle() {
        let suite = UserDefaults(suiteName: "CFTest")!
        var filter = CommunityFilter(userDefaults: suite)
        XCTAssertTrue(filter.enableNSFW(pin: "1234"))
        XCTAssertEqual(filter.filter("nsfw text"), "nsfw text")
        filter.disableNSFW()
        XCTAssertNotEqual(filter.filter("nsfw text"), "nsfw text")
        filter = CommunityFilter(userDefaults: suite)
        XCTAssertFalse(filter.enableNSFW(pin: "wrong"))
        XCTAssertTrue(filter.enableNSFW(pin: "1234"))
        suite.removePersistentDomain(forName: "CFTest")
    }

    func testRegionGating() {
        let suite = UserDefaults(suiteName: "CFRegionTest")!
        var filter = CommunityFilter(userDefaults: suite,
                                     region: "US",
                                     blockedRegions: ["US"]) 
        XCTAssertFalse(filter.enableNSFW(pin: "1111"))
        filter.setRegion("CA")
        XCTAssertTrue(filter.enableNSFW(pin: "1111"))
        XCTAssertTrue(filter.isRegionAllowed())
        suite.removePersistentDomain(forName: "CFRegionTest")
    }
}
