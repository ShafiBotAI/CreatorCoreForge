import XCTest
@testable import CreatorCoreForge

final class MemoryTrackerTests: XCTestCase {
    func testAddAndRetrieveCharacters() {
        let tracker = MemoryTracker()
        tracker.add(character: "Hero", in: "Book1")
        XCTAssertEqual(tracker.characters(in: "Book1"), ["Hero"])
    }

    func testClearBook() {
        let tracker = MemoryTracker()
        tracker.add(character: "Hero", in: "Book1")
        tracker.clear(book: "Book1")
        XCTAssertTrue(tracker.characters(in: "Book1").isEmpty)
    }
}
