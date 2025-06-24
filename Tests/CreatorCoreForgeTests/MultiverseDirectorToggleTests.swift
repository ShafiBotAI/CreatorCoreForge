import XCTest
@testable import CreatorCoreForge

final class MultiverseDirectorToggleTests: XCTestCase {
    func testToggleAndStyleSelection() {
        let director = MultiverseDirectorToggle(styles: ["Anime", "Noir"])
        XCTAssertFalse(director.isEnabled)
        director.toggle()
        XCTAssertTrue(director.isEnabled)
        XCTAssertFalse(director.selectStyle("Fantasy"))
        XCTAssertTrue(director.selectStyle("Anime"))
        XCTAssertEqual(director.currentStyle, "Anime")
    }
}
