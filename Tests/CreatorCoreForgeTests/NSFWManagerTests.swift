import XCTest
@testable import CreatorCoreForge

final class NSFWManagerTests: XCTestCase {
    func testTaggingAndExport() {
        let manager = NSFWManager()
        _ = manager.tagVoiceClip(character: "Hero", text: "moan softly", file: "/tmp/moan.wav")
        XCTAssertEqual(manager.listNSFWClips().count, 1)
        XCTAssertTrue(manager.enableStealthExport(password: "stealthmode"))
        let files = manager.exportNSFWClips()
        XCTAssertEqual(files.first, "/tmp/moan.wav")
    }

    func testExportDisabled() {
        let manager = NSFWManager()
        _ = manager.tagVoiceClip(character: "Hero", text: "moan", file: "/tmp/moan.wav")
        let files = manager.exportNSFWClips()
        XCTAssertTrue(files.isEmpty)
    }

    func testSearchAndClearVault() {
        let manager = NSFWManager()
        manager.clearVault()
        _ = manager.tagVoiceClip(character: "Hero", text: "moan softly", file: "/tmp/moan.wav")
        _ = manager.tagVoiceClip(character: "Villain", text: "touch gently", file: "/tmp/touch.wav")
        let results = manager.searchClips(keyword: "touch")
        XCTAssertEqual(results.count, 1)
        manager.clearVault()
        XCTAssertTrue(manager.listNSFWClips().isEmpty)
    }
}
