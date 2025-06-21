import XCTest
@testable import CreatorCoreForge

final class BookProcessingTests: XCTestCase {
    func testImportBookCreatesChapters() {
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent("book.txt")
        try? "Chapter 1\nHello\n\nChapter 2\nWorld".write(to: tmp, atomically: true, encoding: .utf8)
        let chapters = BookProcessing.importBook(filePath: tmp.path)
        XCTAssertEqual(chapters.count, 2)
    }

    func testAssignVoices() {
        let segs = [Segment(text: "Hi", character: "A"), Segment(text: "Bye", character: "B")]
        let profile = VoiceProfile(name: "Test")
        let map = ["A": profile]
        let tagged = BookProcessing.assignVoices(segs, characterMap: map)
        XCTAssertEqual(tagged[0].voice, profile)
        XCTAssertNil(tagged[1].voice)
    }
}
