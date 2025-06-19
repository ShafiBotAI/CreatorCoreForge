import XCTest
@testable import CreatorCoreForge

final class AppCatalogTests: XCTestCase {
    func testInfoLookup() {
        let info = AppCatalog.info(for: "CoreForge Visual")
        XCTAssertNotNil(info)
        XCTAssertEqual(info?.path, "apps/CoreForgeVisual")
    }

    func testCatalogCount() {
        XCTAssertGreaterThanOrEqual(AppCatalog.all.count, 5)
    }

    func testBuildInfo() {
        let info = AppCatalog.info(for: "CoreForge Build")
        XCTAssertNotNil(info)
        XCTAssertEqual(info?.path, "apps/CoreForgeBuild")
    }
}
