import XCTest
@testable import CreatorCoreForge

final class AutoBundlerTests: XCTestCase {
    func testBundlePlatforms() {
        let bundler = AutoBundler()
        let result = bundler.bundle(platforms: ["iOS", "macOS"])
        XCTAssertEqual(result, ["iOS_bundle", "macOS_bundle"])
    }
}
