import XCTest
@testable import CreatorCoreForge

final class LanguageTranslationManagerTests: XCTestCase {
    func testTranslateSingle() {
        let manager = LanguageTranslationManager(translations: [
            "it": ["hello": "ciao"],
            "de": ["hello": "hallo"]
        ])
        XCTAssertEqual(manager.translate("hello", to: "it"), "ciao")
        XCTAssertEqual(manager.translate("hello", to: "de"), "hallo")
        XCTAssertEqual(manager.translate("hello", to: "fr"), "hello")
    }

    func testTranslateMultiple() {
        let manager = LanguageTranslationManager(translations: [
            "it": ["yes": "sì", "no": "no"],
            "de": ["yes": "ja", "no": "nein"]
        ])
        let resultsIt = manager.translate(contents: ["yes", "no"], to: "it")
        XCTAssertEqual(resultsIt, ["sì", "no"])
        let resultsDe = manager.translate(contents: ["yes", "no"], to: "de")
        XCTAssertEqual(resultsDe, ["ja", "nein"])
    }
}
