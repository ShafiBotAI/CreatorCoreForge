import XCTest
@testable import CreatorCoreForge

final class GlobalVoiceLibraryTests: XCTestCase {
    func testDefaultCount() {
        let voices = GlobalVoiceLibrary.defaultVoices()
        XCTAssertEqual(voices.count, 200)
    }
}
