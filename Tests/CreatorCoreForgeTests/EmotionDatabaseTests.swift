import XCTest
@testable import CreatorCoreForge

final class EmotionDatabaseTests: XCTestCase {
    func testLookupByName() {
        let db = EmotionDatabase()
        let record = db.record(for: "joy")
        XCTAssertEqual(record?.category, "positive")
        XCTAssertTrue(record?.synonyms.contains("happiness") ?? false)
    }

    func testLookupBySynonym() {
        let db = EmotionDatabase()
        let record = db.record(for: "fury")
        XCTAssertEqual(record?.name, "anger")
    }
}
