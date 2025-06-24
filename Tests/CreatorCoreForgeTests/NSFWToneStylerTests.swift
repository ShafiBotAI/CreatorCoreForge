import XCTest
@testable import CreatorCoreForge

final class NSFWToneStylerTests: XCTestCase {
    func testApplySoftStyle() {
        let output = applyNSFWTone(to: "Hello there", context: .soft)
        XCTAssertEqual(output.styledText, "[Soft] Hello there")
        XCTAssertEqual(output.style, .soft)
    }

    func testApplyWhisperStyle() {
        let output = applyNSFWTone(to: "Be quiet", context: .whisper)
        XCTAssertTrue(output.styledText.contains("[Whisper]"))
        XCTAssertEqual(output.style, .whisper)
    }
}
