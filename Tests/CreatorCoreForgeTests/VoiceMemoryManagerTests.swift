import XCTest
@testable import CreatorCoreForge

final class VoiceMemoryManagerTests: XCTestCase {
    func testExportImportCycle() {
        let manager = VoiceMemoryManager.shared
        manager.clear(series: "TestSeries")
        manager.assign(voiceID: "Voice1", to: "Hero", in: "TestSeries")
        manager.assign(voiceID: "Voice2", to: "Villain", in: "TestSeries")

        guard let data = manager.exportAssignments() else {
            XCTFail("Export failed")
            return
        }

        manager.clear(series: "TestSeries")
        XCTAssertNil(manager.voiceID(for: "Hero", in: "TestSeries"))

        manager.importAssignments(data)
        XCTAssertEqual(manager.voiceID(for: "Hero", in: "TestSeries"), "Voice1")
        XCTAssertEqual(manager.voiceID(for: "Villain", in: "TestSeries"), "Voice2")
    }

    func testDiskPersistence() {
        let tempDir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        var manager = VoiceMemoryManager(userDefaults: defaults, directory: tempDir)
        manager.assign(voiceID: "V1", to: "Alice", in: "Saga")

        // Recreate manager to load from disk
        manager = VoiceMemoryManager(userDefaults: UserDefaults(suiteName: UUID().uuidString)!, directory: tempDir)
        XCTAssertEqual(manager.voiceID(for: "Alice", in: "Saga"), "V1")
    }

    func testSeriesAssignmentsRetrieval() {
        let manager = VoiceMemoryManager.shared
        manager.clear(series: "Epic")
        manager.assign(voiceID: "VA", to: "Hero", in: "Epic")
        manager.assign(voiceID: "VB", to: "Villain", in: "Epic")

        let map = manager.assignments(for: "Epic")
        XCTAssertEqual(map["Hero"], "VA")
        XCTAssertEqual(map["Villain"], "VB")

        let grouped = manager.allAssignments()
        XCTAssertEqual(grouped["Epic"]?["Hero"], "VA")
    }
}
