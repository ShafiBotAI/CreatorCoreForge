import XCTest
@testable import CreatorCoreForge

final class SeriesManagerTests: XCTestCase {
    func testAddAndRetrieveBooks() {
        let manager = SeriesManager.shared
        manager.addBook("Book1", toSeries: "SeriesA")
        manager.addBook("Book2", toSeries: "SeriesA")
        XCTAssertEqual(manager.books(inSeries: "SeriesA"), ["Book1", "Book2"])
    }

    func testRemoveBook() {
        let manager = SeriesManager.shared
        manager.addBook("Book3", toSeries: "SeriesB")
        manager.removeBook("Book3", fromSeries: "SeriesB")
        XCTAssertTrue(manager.books(inSeries: "SeriesB").isEmpty)
    }
}
