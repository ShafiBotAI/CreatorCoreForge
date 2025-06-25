import XCTest
@testable import CreatorCoreForge

final class VoiceSyncControllerTests: XCTestCase {
    func testSyncGeneratesSubtitles() {
        let controller = VoiceSyncController()
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("a.mp3")
        try? Data().write(to: url)
        let subs = controller.sync(audioURL: url, script: "Hello\nWorld")
        XCTAssertEqual(subs.count, 2)
    }
}
