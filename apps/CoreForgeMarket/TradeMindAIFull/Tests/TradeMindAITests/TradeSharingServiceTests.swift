import XCTest
@testable import TradeMindAI

final class TradeSharingServiceTests: XCTestCase {
    func testShareReturnsPlatforms() {
        let service = TradeSharingService()
        let result = service.share(message: "test", to: [.telegram, .discord])
        XCTAssertEqual(result, [.telegram, .discord])
    }
}
