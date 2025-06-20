import XCTest
@testable import CreatorCoreForge

final class PlaybackBookmarkingTests: XCTestCase {
    func testBookmarkAndResume() {
        let manager = PlaybackManager()
        let chapters = [
            Chapter(title: "One", audioURL: "1.mp3"),
            Chapter(title: "Two", audioURL: "2.mp3")
        ]
        manager.loadChapters(chapters)
        XCTAssertTrue(manager.playCurrentChapter())
        manager.nextChapter()
        manager.bookmark()
        manager.nextChapter()
        XCTAssertFalse(manager.nextChapter())
        XCTAssertTrue(manager.resume())
    }

    func testPreviousChapterBounds() {
        let manager = PlaybackManager()
        manager.loadChapters([Chapter(title: "A", audioURL: "a.mp3")])
        XCTAssertFalse(manager.previousChapter())
    }
}

