import XCTest
@testable import CreatorCoreForge

final class HeroSpotlightBackgroundTests: XCTestCase {
    func testGenerate() {
        let generator = HeroSpotlightBackground()
        let grid = generator.generate(width: 5, hero: "H")
        XCTAssertEqual(grid.count, 3)
        XCTAssertEqual(grid[1][2], "H")
    }
}
