import XCTest
@testable import CreatorCoreForge

final class EmotionAnalyzerTests: XCTestCase {
    func testRecommendTone() {
        let analyzer = EmotionAnalyzer()
        XCTAssertEqual(analyzer.recommendTone(for: "This is amazing!"), "excited")
        XCTAssertEqual(analyzer.recommendTone(for: "I am so sad"), "somber")
        XCTAssertEqual(analyzer.recommendTone(for: "He was furious"), "angry")
        XCTAssertEqual(analyzer.recommendTone(for: "Just reading"), "calm")
    }
}
