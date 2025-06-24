import XCTest
@testable import CreatorCoreForge

final class LocalElevenLabsClientTests: XCTestCase {
    func testListVoicesReturnsDefault() {
        let client = LocalElevenLabsClient()
        XCTAssertFalse(client.listVoices().isEmpty)
    }

    func testVoiceInfoRetrieval() {
        var client = LocalElevenLabsClient(voices: [])
        let profile = VoiceProfile(name: "Sample")
        client.addVoice(profile)
        XCTAssertEqual(client.voiceInfo(id: profile.id)?.name, "Sample")
    }

    func testSynthesizeProducesData() {
        let profile = VoiceProfile(name: "Tester")
        let client = LocalElevenLabsClient(voices: [profile])
        let exp = expectation(description: "synth")
        client.synthesize(text: "Hi", voiceID: profile.id) { result in
            switch result {
            case .success(let data):
                XCTAssertFalse(data.isEmpty)
            case .failure:
                XCTFail("Unexpected failure")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
