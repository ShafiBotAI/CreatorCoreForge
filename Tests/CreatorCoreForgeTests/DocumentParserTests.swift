import XCTest
@testable import CreatorCoreForge

final class DocumentParserTests: XCTestCase {
    func testParseTxtFile() throws {
        let parser = DocumentParser()
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent("sample.txt")
        try "hello".write(to: tmp, atomically: true, encoding: .utf8)
        let text = try parser.parse(url: tmp)
        XCTAssertEqual(text.trimmingCharacters(in: .whitespacesAndNewlines), "hello")
        try? FileManager.default.removeItem(at: tmp)
    }

    func testUnsupportedFileThrows() {
        let parser = DocumentParser()
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("file.xyz")
        XCTAssertThrowsError(try parser.parse(url: url)) { error in
            guard case DocumentParser.ParserError.unsupportedType = error else {
                return XCTFail("Wrong error")
            }
        }
    }

    func testParseDocxFile() throws {
        let parser = DocumentParser()
        let tmpDir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let wordDir = tmpDir.appendingPathComponent("word")
        try FileManager.default.createDirectory(at: wordDir, withIntermediateDirectories: true)
        let xmlURL = wordDir.appendingPathComponent("document.xml")
        let xml = "<w:document><w:body><w:p><w:t>Hello Docx</w:t></w:p></w:body></w:document>"
        try xml.write(to: xmlURL, atomically: true, encoding: .utf8)
        let docxURL = tmpDir.appendingPathComponent("sample.docx")
        let process = Process()
        process.launchPath = "/usr/bin/zip"
        process.currentDirectoryURL = tmpDir
        process.arguments = ["-q", "-r", docxURL.path, "word"]
        try process.run()
        process.waitUntilExit()
        let text = try parser.parse(url: docxURL)
        XCTAssertTrue(text.contains("Hello Docx"))
        try? FileManager.default.removeItem(at: tmpDir)
        try? FileManager.default.removeItem(at: docxURL)
    }
}
