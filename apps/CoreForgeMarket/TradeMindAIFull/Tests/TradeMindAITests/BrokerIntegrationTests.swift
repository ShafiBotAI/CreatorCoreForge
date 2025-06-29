import XCTest
@testable import TradeMindAI

final class BrokerIntegrationTests: XCTestCase {
    func testSupportedBrokerConnects() {
        let bi = BrokerIntegration()
        XCTAssertTrue(bi.connect(to: "Robinhood"))
    }

    func testUnsupportedBrokerFails() {
        let bi = BrokerIntegration()
        XCTAssertFalse(bi.connect(to: "Unknown"))
    }
}
