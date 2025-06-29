import XCTest
@testable import TradeMindAI

final class GlobalNewsMapTests: XCTestCase {
    func testMapGroupsByRegion() {
        let mapper = GlobalNewsMap()
        let result = mapper.map(headlines: ["US": "Headline", "US": "Another"])
        XCTAssertEqual(result["US"]?.count, 2)
    }
}
