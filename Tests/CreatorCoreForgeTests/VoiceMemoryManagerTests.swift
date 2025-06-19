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
}
