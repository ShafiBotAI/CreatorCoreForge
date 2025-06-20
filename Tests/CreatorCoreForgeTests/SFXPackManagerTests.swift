import XCTest
@testable import CreatorCoreForge

final class SFXPackManagerTests: XCTestCase {
    func testBuiltInPacksLoaded() {
        let packs = SFXPackManager.shared.availablePacks(includeNSFW: true)
        XCTAssertGreaterThan(packs.count, 0)
        XCTAssertTrue(packs.contains { $0.name == "Soft Moans" })
    }

    func testNSFWFiltering() {
        let safePacks = SFXPackManager.shared.availablePacks()
        XCTAssertFalse(safePacks.contains { $0.isNSFW })
    }
}
