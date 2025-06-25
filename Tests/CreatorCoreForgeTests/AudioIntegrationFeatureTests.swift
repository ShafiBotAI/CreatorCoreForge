import XCTest
@testable import CreatorCoreForge

final class AudioIntegrationFeatureTests: XCTestCase {
    func testVoiceManagerMapping() {
        let manager = VoiceManager()
        let profile = VoiceProfile(name: "Test")
        manager.assign(profile, to: "Bob", in: "Book1")
        let stored = manager.voiceProfile(for: "Bob", in: "Book1")
        XCTAssertEqual(stored?.id, profile.id)
    }

    func testAmbientMixerEmotionSync() {
        let mixer = AmbientMixer()
        mixer.syncEmotion("sad")
        XCTAssertEqual(mixer.currentEmotion, "sad")
    }

    @available(macOS 12.0, iOS 15.0, *)
    func testExportLive() async throws {
        let system = ExportSystem()
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent("live.wav")
        try? FileManager.default.removeItem(at: tmp)
        let stream = AsyncStream<Data> { continuation in
            continuation.yield("abc".data(using: .utf8)!)
            continuation.finish()
        }
        let url = try await system.exportLive(stream, to: tmp)
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
    }

    func testOfflineQueueCancel() {
        let queue = OfflineQueue()
        var ran = false
        let exp = expectation(description: "cancel")
        queue.add { ran = true; exp.fulfill() }
        queue.cancelAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertFalse(ran)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

