import XCTest
@testable import CreatorCoreForge

final class AppCatalogTests: XCTestCase {
    func testInfoLookup() {
        let info = AppCatalog.info(for: "LoreForgeAI")
        XCTAssertNotNil(info)
        XCTAssertEqual(info?.path, "apps/LoreForgeAI")
    }

    func testCatalogCount() {
        XCTAssertGreaterThanOrEqual(AppCatalog.all.count, 5)
    }

    func testAppForgeInfo() {
        let info = AppCatalog.info(for: "AppForgeAI")
        XCTAssertNotNil(info)
        XCTAssertEqual(info?.path, "apps/AppForgeAI")
    }
}
