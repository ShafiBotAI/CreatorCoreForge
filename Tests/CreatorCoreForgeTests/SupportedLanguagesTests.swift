import XCTest
@testable import CreatorCoreForge

final class SupportedLanguagesTests: XCTestCase {
    func testLanguageCount() {
        XCTAssertGreaterThanOrEqual(SupportedLanguage.allCases.count, 60)
    }
}
