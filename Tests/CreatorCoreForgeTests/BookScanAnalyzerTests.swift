import XCTest
@testable import CreatorCoreForge

final class BookScanAnalyzerTests: XCTestCase {
    func testAnalyzeCountsWords() {
        let analyzer = BookScanAnalyzer()
        let chapters = [
            Chapter(title: "One", text: "Hello world", order: 0),
            Chapter(title: "Two", text: "Hello again", order: 1)
        ]
        let freq = analyzer.analyze(chapters: chapters)
        XCTAssertEqual(freq["hello"], 2)
        XCTAssertEqual(freq["world"], 1)
    }
}
