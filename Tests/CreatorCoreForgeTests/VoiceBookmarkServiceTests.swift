import XCTest
@testable import CreatorCoreForge

final class VoiceBookmarkServiceTests: XCTestCase {
    func testAddAndRetrieveBookmarks() {
        let svc = VoiceBookmarkService()
        let url = URL(fileURLWithPath: "/tmp/test.wav")
        svc.addBookmark(for: url, time: 1.5, note: "Intro")
        svc.addBookmark(for: url, time: 3.0, note: "Verse")
        let bookmarks = svc.bookmarks(for: url)
        XCTAssertEqual(bookmarks.count, 2)
        XCTAssertEqual(bookmarks[0].note, "Intro")
    }

    func testClearBookmarks() {
        let svc = VoiceBookmarkService()
        let url = URL(fileURLWithPath: "/tmp/test.wav")
        svc.addBookmark(for: url, time: 1.0, note: "A")
        svc.clearBookmarks(for: url)
        XCTAssertTrue(svc.bookmarks(for: url).isEmpty)
    }
}
