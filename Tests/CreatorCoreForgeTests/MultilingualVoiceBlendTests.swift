import XCTest
@testable import CreatorCoreForge

final class MultilingualVoiceBlendTests: XCTestCase {
    func testBlendTwo() {
        XCTAssertEqual(MultilingualVoiceBlend.blend("en-US", with: "es-ES"), "en-US-es-ES")
    }

    func testBlendArray() {
        let id = MultilingualVoiceBlend.blend(voices: ["a", "b", "c"])
        XCTAssertEqual(id, "a-b-c")
    }
}
