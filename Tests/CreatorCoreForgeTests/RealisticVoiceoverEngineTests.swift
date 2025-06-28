import XCTest
@testable import CreatorCoreForge

final class RealisticVoiceoverEngineTests: XCTestCase {
    func testSpeakProducesData() {
        let profile = VoiceProfile(name: "NextGen", depth: 1.3, scope: 1.2)
        let segment = Segment(text: "Hello world", character: "narrator", voice: profile)
        let engine = RealisticVoiceoverEngine()
        let exp = expectation(description: "speak")
        engine.speak(segment) { result in
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

    func testEmotionChangesOutput() {
        let profile = VoiceProfile(name: "NextGen")
        let segment = Segment(text: "Hello world", voice: profile)
        let engine = RealisticVoiceoverEngine()
        let exp1 = expectation(description: "neutral")
        var data1: Data?
        engine.speak(segment) { result in
            if case .success(let data) = result { data1 = data }
            exp1.fulfill()
        }
        let exp2 = expectation(description: "sad")
        var data2: Data?
        engine.speak(segment, emotion: "sad") { result in
            if case .success(let data) = result { data2 = data }
            exp2.fulfill()
        }
        wait(for: [exp1, exp2], timeout: 1)
        XCTAssertNotNil(data1)
        XCTAssertNotNil(data2)
        XCTAssertNotEqual(data1, data2)
    }

    func testDepthScopeOverrides() {
        let profile = VoiceProfile(name: "Base")
        let segment = Segment(text: "Hi", voice: profile)
        let engine = RealisticVoiceoverEngine()

        let exp1 = expectation(description: "default")
        var data1: Data?
        engine.speak(segment) { result in
            if case .success(let data) = result { data1 = data }
            exp1.fulfill()
        }

        let exp2 = expectation(description: "override")
        var data2: Data?
        engine.speak(segment, depth: 1.5, scope: 1.2) { result in
            if case .success(let data) = result { data2 = data }
            exp2.fulfill()
        }

        wait(for: [exp1, exp2], timeout: 1)
        XCTAssertNotNil(data1)
        XCTAssertNotNil(data2)
        XCTAssertNotEqual(data1, data2)
    }
}
