import XCTest
@testable import CreatorCoreForge

final class CoreForgeAudioModulePresenceTests: XCTestCase {
    func testExportSystem() throws {
        let data = "test".data(using: .utf8)!
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("sample.mp3")
        try? FileManager.default.removeItem(at: url)
        try ExportSystem().exportMP3(data: data, to: url)
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
    }

    func testSegmentEngine() {
        let segs = SegmentEngine().segments(from: "A\n\nB")
        XCTAssertEqual(segs.count, 2)
    }

    func testMemoryEngine() {
        let suiteName = UUID().uuidString
        let mem = MemoryEngine(character: CharacterMemoryEngine(), visual: VisualMemoryEngine(store: UserDefaults(suiteName: suiteName)!))
        mem.rememberTrait("mood", value: "happy", character: "Ann")
        XCTAssertEqual(mem.trait("mood", for: "Ann"), "happy")
        mem.addFrame("f1", project: "p1")
        XCTAssertEqual(mem.frames(for: "p1"), ["f1"])
        UserDefaults().removePersistentDomain(forName: suiteName)
    }

    func testOfflineQueue() {
        let queue = OfflineQueue()
        let exp = expectation(description: "run")
        queue.add { exp.fulfill() }
        wait(for: [exp], timeout: 1)
    }
}
