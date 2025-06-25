import XCTest
@testable import CreatorCoreForge

final class PromptParserEngineTests: XCTestCase {
    func testLanguageDetection() {
        let engine = PromptParserEngine()
        let result = engine.parseSchema(from: "Hola mundo")
        XCTAssertEqual(result.language.prefix(2), "es")
    }
}
