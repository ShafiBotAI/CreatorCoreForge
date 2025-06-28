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

    func testCustomSampleRate() {
        let engine = LocalVoiceAI()
        let profile = VoiceProfile(name: "Test")
        let expectation = XCTestExpectation(description: "rate")
        engine.synthesize(text: "Hi", with: profile, sampleRate: 22_050) { result in
            switch result {
            case .success(let data):
                let rate = data.subdata(in: 24..<28).withUnsafeBytes { $0.load(as: UInt32.self) }
                XCTAssertEqual(rate, 22_050)
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

    func testDepthAndScopeAffectOutput() {
        let engine = LocalVoiceAI()
        let defaultProfile = VoiceProfile(name: "Base")
        let richProfile = VoiceProfile(name: "Rich", depth: 1.5, scope: 1.2)

        let exp1 = expectation(description: "base")
        var data1: Data?
        engine.synthesize(text: "Hi", with: defaultProfile) { result in
            if case .success(let d) = result { data1 = d }
            exp1.fulfill()
        }

        let exp2 = expectation(description: "rich")
        var data2: Data?
        engine.synthesize(text: "Hi", with: richProfile) { result in
            if case .success(let d) = result { data2 = d }
            exp2.fulfill()
        }

        wait(for: [exp1, exp2], timeout: 1)
        XCTAssertNotNil(data1)
        XCTAssertNotNil(data2)
        XCTAssertNotEqual(data1, data2)
    }
}

