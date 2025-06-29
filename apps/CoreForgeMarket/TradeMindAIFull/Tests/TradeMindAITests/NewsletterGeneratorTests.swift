import XCTest
@testable import TradeMindAI

final class NewsletterGeneratorTests: XCTestCase {
    func testGeneratesHeadline() {
        let gen = NewsletterGenerator()
        let news = gen.generate(portfolio: ["A": 60, "B": 40])
        XCTAssertTrue(news.contains("A"))
    }
}
