import XCTest
@testable import CreatorCoreForge

final class AutoTranslateServiceTests: XCTestCase {
    func testTranslate() {
        let svc = AutoTranslateService(dictionaries: ["es": ["hello": "hola", "world": "mundo"]])
        let result = svc.translate("hello world", to: "es")
        XCTAssertEqual(result, "hola mundo")
    }

    func testTranslateChapters() {
        let svc = AutoTranslateService(dictionaries: ["es": ["test": "prueba"]])
        let chapter = Chapter(title: "One", text: "test", order: 1)
        let out = svc.translate(chapters: [chapter], to: "es")
        XCTAssertEqual(out[0].text, "prueba")
    }
}
