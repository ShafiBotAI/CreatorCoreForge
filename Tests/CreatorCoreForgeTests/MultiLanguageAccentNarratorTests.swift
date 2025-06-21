import XCTest
@testable import CreatorCoreForge

final class MultiLanguageAccentNarratorTests: XCTestCase {
    func testAccentPrefixAndStyle() {
        let narrator = MultiLanguageAccentNarrator()
        let output = narrator.narrate("Hello there", style: .sensual, accent: .french)
        XCTAssertTrue(output.styledText.contains("[French]"))
        XCTAssertTrue(output.styledText.contains("[Sensual]"))
        XCTAssertEqual(output.style, .sensual)
    }

    func testLanguageDetection() {
        let narrator = MultiLanguageAccentNarrator()
        XCTAssertEqual(narrator.detectLanguage(of: "Hola"), .spanish)
    }
}
