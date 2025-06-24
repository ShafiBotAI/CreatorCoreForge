import XCTest
@testable import CreatorCoreForge

final class EbookImporterTests: XCTestCase {
    func testDetectFormat() {
        let importer = EbookImporter()
        XCTAssertEqual(importer.detectFormat(filename: "story.txt"), .txt)
        XCTAssertEqual(importer.detectFormat(filename: "doc.pdf"), .pdf)
        XCTAssertEqual(importer.detectFormat(filename: "novel.epub"), .epub)
        XCTAssertEqual(importer.detectFormat(filename: "book.mobi"), .mobi)
        XCTAssertEqual(importer.detectFormat(filename: "story.azw"), .azw)
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

    func testImportMobi() {
        let path = "/tmp/test.mobi"
        _ = FileManager.default.createFile(atPath: path, contents: Data(), attributes: nil)
        let importer = EbookImporter()
        let chapters = importer.importEbook(from: path)
        XCTAssertEqual(chapters.count, 2)
    }

    func testImportAzw() {
        let path = "/tmp/test.azw"
        _ = FileManager.default.createFile(atPath: path, contents: Data(), attributes: nil)
        let importer = EbookImporter()
        let chapters = importer.importEbook(from: path)
        XCTAssertEqual(chapters.count, 2)
    }
}
