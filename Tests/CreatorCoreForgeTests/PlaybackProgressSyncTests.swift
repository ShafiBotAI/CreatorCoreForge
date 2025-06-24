import XCTest
@testable import CreatorCoreForge

final class PlaybackProgressSyncTests: XCTestCase {
    private final class DummySync: SyncService {
        var uploaded: [String: Any]?
        var fetchData: [String: Any]?
        func upload(_ settings: [String : Any], userID: String, completion: @escaping (Bool) -> Void) {
            uploaded = settings
            completion(true)
        }
        func fetch(userID: String, completion: @escaping ([String : Any]?) -> Void) {
            completion(fetchData)
        }
    }

    func testSaveAndLoadLocalProgress() {
        let temp = FileManager.default.temporaryDirectory
        let sync = DummySync()
        let manager = PlaybackProgressSync(userID: "u1", directory: temp, sync: sync)
        manager.saveProgress(bookID: "book1", chapter: 3)
        let exp = expectation(description: "load")
        manager.loadProgress(bookID: "book1") { idx in
            XCTAssertEqual(idx, 3)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(sync.uploaded?["book1"] as? Int, 3)
    }

    func testFetchRemoteProgressWhenLocalMissing() {
        let temp = FileManager.default.temporaryDirectory
        let sync = DummySync()
        sync.fetchData = ["bookX": 2]
        let manager = PlaybackProgressSync(userID: "u2", directory: temp, sync: sync)
        let exp = expectation(description: "remote")
        manager.loadProgress(bookID: "bookX") { idx in
            XCTAssertEqual(idx, 2)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
