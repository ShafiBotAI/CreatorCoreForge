import XCTest
@testable import CreatorCoreForge

final class EbookImporterTests: XCTestCase {
    func testDetectFormat() {
        let importer = EbookImporter()
        XCTAssertEqual(importer.detectFormat(filename: "story.txt"), .txt)
        XCTAssertEqual(importer.detectFormat(filename: "doc.pdf"), .pdf)
        XCTAssertEqual(importer.detectFormat(filename: "novel.epub"), .epub)
        XCTAssertEqual(importer.detectFormat(filename: "unknown.doc"), .unsupported)
    }

    func testImportTxt() {
        let tmp = "Chapter 1\nHello\n\nChapter 2\nWorld"
        let path = "/tmp/test.txt"
        try? tmp.write(toFile: path, atomically: true, encoding: .utf8)
        let importer = EbookImporter()
        let chapters = importer.importEbook(from: path)
        XCTAssertEqual(chapters.count, 2)
    }
}
