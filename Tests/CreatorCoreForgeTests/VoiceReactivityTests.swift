import XCTest
@testable import CreatorCoreForge

final class VoiceReactivityTests: XCTestCase {
    func testReact() {
        let vr = VoiceReactivity()
        let pitch = vr.react(to: 0.8)
        XCTAssertGreaterThan(pitch, 1.0)
    }
}
