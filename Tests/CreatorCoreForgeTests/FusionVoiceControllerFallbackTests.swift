import XCTest
@testable import CreatorCoreForge

final class FusionVoiceControllerFallbackTests: XCTestCase {
    private final class FailingRenderer: TTSAudioRendering {
        func render(text: String, voiceID: String, completion: @escaping (Result<Data, Error>) -> Void) {
            completion(.failure(NSError(domain: "test", code: -1)))
        }
    }

    private final class MockRenderer: TTSAudioRendering {
        func render(text: String, voiceID: String, completion: @escaping (Result<Data, Error>) -> Void) {
            completion(.success(Data("remote".utf8)))
        }
    }

    func testFallbackToLocalOnFailure() {
        let controller = FusionVoiceController(remoteRenderer: FailingRenderer())
        let profile = VoiceProfile(name: "Test")
        let exp = expectation(description: "local")
        controller.speak(text: "Hello", using: profile) { data in
            XCTAssertNotNil(data)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testUsesRemoteWhenConnected() {
        NetworkMonitor.shared.setTestConnection(true)
        AppSettings.shared.offlineMode = false
        let controller = FusionVoiceController(remoteRenderer: MockRenderer())
        let profile = VoiceProfile(name: "Test")
        let exp = expectation(description: "remote")
        controller.speak(text: "Hi", using: profile) { data in
            XCTAssertEqual(data, Data("remote".utf8))
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testFallsBackWhenOffline() {
        NetworkMonitor.shared.setTestConnection(false)
        AppSettings.shared.offlineMode = false
        let controller = FusionVoiceController(remoteRenderer: MockRenderer())
        let profile = VoiceProfile(name: "Test")
        let exp = expectation(description: "local")
        controller.speak(text: "Hi", using: profile) { data in
            XCTAssertNotEqual(data, Data("remote".utf8))
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
