import XCTest
@testable import CreatorCoreForge

final class FilingsDatabaseTests: XCTestCase {
    func testSaveAndList() throws {
        let tempDir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let db = FilingsDatabase(directory: tempDir)
        let filing = Filing(title: "Test", date: Date(timeIntervalSince1970: 0), url: URL(string: "https://example.com")!)
        try db.save(filing)
        XCTAssertEqual(db.list().count, 1)
        XCTAssertEqual(db.list().first?.title, "Test")
    }

    func testClear() throws {
        let tempDir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let db = FilingsDatabase(directory: tempDir)
        let filing = Filing(title: "Test", date: Date(), url: URL(string: "https://example.com")!)
        try db.save(filing)
        try db.clear()
        XCTAssertTrue(db.list().isEmpty)
    }
}
