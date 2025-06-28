import XCTest
@testable import CreatorCoreForge

final class NextGenSpeechServiceTests: XCTestCase {
    func testGenerateProducesData() {
        let service = NextGenSpeechService()
        let profile = VoiceProfile(name: "Tester")
        let expectation = XCTestExpectation(description: "gen")
        service.generate(text: "Hi", profile: profile) { data in
            XCTAssertNotNil(data)
            XCTAssertFalse(data?.isEmpty ?? true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testRecognizeUtf8() {
        let service = NextGenSpeechService()
        let text = "hello"
        let data = Data(text.utf8)
        XCTAssertEqual(service.recognize(data), text)
    }

    func testRecognizeNoise() {
        let service = NextGenSpeechService()
        let loudData = Data([255, 255, 255])
        XCTAssertEqual(service.recognize(loudData), "LOUD")
        let softData = Data([0, 0, 0])
        XCTAssertEqual(service.recognize(softData), "SOFT")
    }
}
