import XCTest
@testable import CreatorCoreForge

final class MultivoiceCharacterModeTests: XCTestCase {
    func testAssignAndRemove() {
        let mode = MultivoiceCharacterMode.shared
        mode.clearVoices(for: "Hero")
        mode.assignVoice("v1", to: "Hero")
        mode.assignVoice("v2", to: "Hero")
        XCTAssertEqual(mode.voices(for: "Hero"), ["v1", "v2"])
        mode.removeVoice("v1", from: "Hero")
        XCTAssertEqual(mode.voices(for: "Hero"), ["v2"])
    }
}
