import XCTest
@testable import CreatorCoreForge

final class BatchImportToolTests: XCTestCase {
    func testImportsMultipleBooks() async throws {
        let tool = BatchImportTool()
        let tmpDir = FileManager.default.temporaryDirectory
        let url1 = tmpDir.appendingPathComponent("sample1.txt")
        let url2 = tmpDir.appendingPathComponent("sample2.txt")
        try "Hello".write(to: url1, atomically: true, encoding: .utf8)
        try "World".write(to: url2, atomically: true, encoding: .utf8)
        let result = try await tool.importBooks(at: [url1, url2])
        XCTAssertEqual(result[url1]?.count, 1)
        XCTAssertEqual(result[url2]?.count, 1)
        try? FileManager.default.removeItem(at: url1)
        try? FileManager.default.removeItem(at: url2)
    }
}
