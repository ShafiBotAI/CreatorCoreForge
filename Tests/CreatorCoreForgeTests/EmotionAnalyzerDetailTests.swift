import XCTest
@testable import CreatorCoreForge

final class EmotionAnalyzerDetailTests: XCTestCase {
    func testDetailedEmotionProvidesPitch() {
        let analyzer = EmotionAnalyzer()
        let detail = analyzer.detailedEmotion(for: "Wow!")
        XCTAssertEqual(detail.emotion, "excited")
        XCTAssertTrue(detail.pitch > 1.0)
    }
}
