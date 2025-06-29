import XCTest
@testable import CreatorCoreForge

final class EnhancedTTSPlayerTests: XCTestCase {
#if canImport(AVFoundation)
    func testPlayInvokesCompletion() {
        let player = EnhancedTTSPlayer()
        let profile = VoiceProfile(name: "Test")
        let exp = expectation(description: "play")
        player.play(text: "Hello", profile: profile) { success in
            XCTAssertTrue(success)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2)
        player.stop()
    }
#else
    func testPlayInvokesCompletion() throws {
        throw XCTSkip("AVFoundation not available on this platform")
    }
#endif
}
