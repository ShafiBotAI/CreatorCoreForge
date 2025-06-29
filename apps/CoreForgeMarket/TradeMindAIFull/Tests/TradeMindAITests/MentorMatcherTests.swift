import XCTest
@testable import TradeMindAI

final class MentorMatcherTests: XCTestCase {
    func testMatchReturnsIndex() {
        let matcher = MentorMatcher()
        let idx = matcher.match(style: [1, 1], mentors: [[0, 0], [1, 1.1]])
        XCTAssertEqual(idx, 1)
    }
}
