import XCTest
@testable import CreatorCoreForge

final class LocalVoiceAITests: XCTestCase {
    func testSynthesisReturnsData() {
        let engine = LocalVoiceAI()
        let profile = VoiceProfile(name: "Test")
        let expectation = XCTestExpectation(description: "synth")
        engine.synthesize(text: "Hello", with: profile) { result in
            switch result {
            case .success(let data):
                XCTAssertFalse(data.isEmpty)
            case .failure:
                XCTFail("Unexpected failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testCloneProducesProfile() {
        let engine = LocalVoiceAI()
        let expectation = XCTestExpectation(description: "clone")
        engine.cloneVoice(from: Data("sample".utf8), name: "Clone") { profile in
            XCTAssertEqual(profile.name, "Clone")
            XCTAssertFalse(profile.id.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
