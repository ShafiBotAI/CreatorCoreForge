import XCTest
@testable import VerseForgeAI

final class TrendAnalyzerTests: XCTestCase {
    func testTrendingPhrases() {
        let lyrics = [
            "Love in the air tonight",
            "Feel the love and light",
            "Dance with love all night"
        ]
        let analyzer = TrendAnalyzer()
        let trends = analyzer.trendingPhrases(from: lyrics, top: 1)
        XCTAssertEqual(trends.first, "love")
    }
}
