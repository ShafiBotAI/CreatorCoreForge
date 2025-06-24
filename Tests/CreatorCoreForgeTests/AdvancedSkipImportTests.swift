import XCTest
@testable import CreatorCoreForge

final class AdvancedSkipImportTests: XCTestCase {
    func testSkipKeywords() async throws {
        let fm = FileManager.default
        let tmp = fm.temporaryDirectory.appendingPathComponent("skip_book.txt")
        let text = """
Prologue
This is intro
Chapter 1
Real content
"""
        try text.write(to: tmp, atomically: true, encoding: .utf8)
        let chapters = try await BookImporter.importBookSkipping(from: tmp, skipKeywords: ["Prologue"])
        XCTAssertEqual(chapters.count, 1)
        XCTAssertEqual(chapters[0].title, "Chapter 1")
    }

    func testDefaultSkipKeywords() async throws {
        let fm = FileManager.default
        let tmp = fm.temporaryDirectory.appendingPathComponent("adv_skip.txt")
        let text = """
Prologue
Intro text
Chapter 1
Real content
"""
        try text.write(to: tmp, atomically: true, encoding: .utf8)
        let chapters = try await AdvancedSkipImport.importSkippingExtras(from: tmp)
        XCTAssertEqual(chapters.count, 1)
        XCTAssertEqual(chapters[0].title, "Chapter 1")
    }
}
