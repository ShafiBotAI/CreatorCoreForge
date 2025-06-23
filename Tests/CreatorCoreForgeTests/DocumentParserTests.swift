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
}
