import XCTest
@testable import VerseForgeAI

final class BeatMatcherTests: XCTestCase {
    func testSuggestTransition() {
        let matcher = BeatMatcher()
        let result = matcher.suggestTransition(from: 120, to: 122)
        XCTAssertEqual(result, "Direct mix")
    }
}
