import XCTest
@testable import CreatorCoreForge

final class PromptParserTests: XCTestCase {
    func testNormalizationBalancesQuotes() {
        let parser = PromptParser()
        let result = parser.normalize("Hello \"world")
        XCTAssertEqual(result, "Hello \"world\"")
    }

    func testParseDetectsLanguage() {
        let parser = PromptParser()
        let parsed = parser.parse("Hola amigo")
        XCTAssertEqual(parsed.language, .spanish)
    }
}
