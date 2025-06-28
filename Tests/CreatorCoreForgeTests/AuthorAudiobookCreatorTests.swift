import XCTest
@testable import CreatorCoreForge

final class AuthorAudiobookCreatorTests: XCTestCase {
    func testGeneratedChaptersAreACXCompliant() async throws {
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent("book.txt")
        try "Chapter 1\nHello".write(to: tmp, atomically: true, encoding: .utf8)
        let creator = AuthorAudiobookCreator(importer: BookImporter())
        let chapters = try await creator.generateChapters(from: tmp)
        XCTAssertFalse(chapters.isEmpty)
        let data = try Data(contentsOf: chapters[0])
        XCTAssertTrue(ACXComplianceChecker().isCompliant(data: data))
    }
}
