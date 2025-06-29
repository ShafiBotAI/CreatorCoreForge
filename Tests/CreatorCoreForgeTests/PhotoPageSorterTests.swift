import XCTest
@testable import CreatorCoreForge

final class PhotoPageSorterTests: XCTestCase {
    func testReordersPagesByNumber() {
        let p1 = "Page 1\nFirst".data(using: .utf8)!
        let p2 = "Page 2\nSecond".data(using: .utf8)!
        let p3 = "Page 3\nThird".data(using: .utf8)!
        let sorter = PhotoPageSorter()
        let combined = sorter.combinedText(from: [p3, p1, p2])
        XCTAssertEqual(combined, "Page 1\nFirst\nPage 2\nSecond\nPage 3\nThird")
    }

    func testMaintainsOrderWithoutNumbers() {
        let a = "Intro".data(using: .utf8)!
        let b = "More".data(using: .utf8)!
        let sorter = PhotoPageSorter()
        let combined = sorter.combinedText(from: [b, a])
        XCTAssertEqual(combined, "More\nIntro")
    }
}
