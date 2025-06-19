import XCTest
@testable import CreatorCoreForge

final class BestsellerStructureEngineTests: XCTestCase {
    func testBasicOutline() {
        let sample = [
            "Chapter 1\n...\nChapter 2\n...\nChapter 3",
            "Chapter 1\n...\nChapter 2"
        ]
        let engine = BestsellerStructureEngine()
        let outline = engine.analyze(books: sample)
        XCTAssertEqual(outline.first, "Introduction")
        XCTAssertTrue(outline.contains("Climax"))
        XCTAssertEqual(outline.last, "Conclusion")
    }
}
