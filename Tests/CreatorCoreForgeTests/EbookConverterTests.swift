import XCTest
@testable import CreatorCoreForge

final class EbookConverterTests: XCTestCase {
    func testConvertSplitsChapters() {
        let text = "Chapter 1\n\nChapter 2"
        let converter = EbookConverter()
        let segments = converter.convertEbookToAudio(ebookText: text)
        XCTAssertEqual(segments.count, 2)
        XCTAssertTrue(segments[0].audioFileURL.contains("chapter1"))
    }
}
