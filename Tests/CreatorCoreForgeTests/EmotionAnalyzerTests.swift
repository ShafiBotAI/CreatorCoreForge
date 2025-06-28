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

    func testAnalyzeEmotion() {
        let analyzer = EmotionAnalyzer()
        let profile = analyzer.analyzeEmotion(from: "I am furious!!")
        XCTAssertEqual(profile.emotion, "angry")
        XCTAssertTrue(profile.intensity > 0.5)
    }

    func testClassifySentence() {
        let analyzer = EmotionAnalyzer()
        XCTAssertEqual(analyzer.classify(sentence: "Wow!"), "excited")
        XCTAssertEqual(analyzer.classify(sentence: "Is this real?"), "curious")
        XCTAssertEqual(analyzer.classify(sentence: "I feel so sad"), "sad")
        XCTAssertEqual(analyzer.classify(sentence: "Just a line"), "neutral")
    }
}
