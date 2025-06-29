import XCTest
@testable import TradeMindAI

final class ThumbnailHeadlineGeneratorTests: XCTestCase {
    func testGenerateHeadlineAndThumbnail() {
        let gen = ThumbnailHeadlineGenerator()
        let result = gen.generate(for: "btc breakout")
        XCTAssertEqual(result.thumbnail, "btc_breakout.png")
        XCTAssertTrue(result.headline.contains("Btc breakout".capitalized))
    }
}
