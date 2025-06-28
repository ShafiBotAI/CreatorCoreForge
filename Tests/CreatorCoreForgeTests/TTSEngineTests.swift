import XCTest
@testable import CreatorCoreForge

final class TTSEngineTests: XCTestCase {
    func testSynthesizeReturnsData() {
        let engine = TTSEngine()
        let profile = VoiceProfile(name: "Tester")
        let exp = expectation(description: "tts")
        engine.synthesize("Hello there.", profile: profile) { data in
            XCTAssertNotNil(data)
            XCTAssertFalse(data?.isEmpty ?? true)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
