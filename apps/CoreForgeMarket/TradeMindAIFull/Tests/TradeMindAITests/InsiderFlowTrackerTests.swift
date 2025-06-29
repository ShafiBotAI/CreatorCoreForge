import XCTest
@testable import TradeMindAI
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class InsiderFlowTrackerTests: XCTestCase {
    func testFetchDarkPoolAlertsMock() {
        class MockProtocol: URLProtocol {
            static var data: Data?
            override class func canInit(with request: URLRequest) -> Bool { true }
            override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
            override func startLoading() {
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: MockProtocol.data ?? Data())
                client?.urlProtocolDidFinishLoading(self)
            }
            override func stopLoading() {}
        }

        let json = try! JSONSerialization.data(withJSONObject: ["alerts": ["DP" ]])
        MockProtocol.data = json
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockProtocol.self]
        let tracker = InsiderFlowTracker(session: URLSession(configuration: config))
        let exp = expectation(description: "alerts")
        tracker.fetchDarkPoolAlerts(ticker: "AAPL") { alerts in
            XCTAssertEqual(alerts, ["DP"])
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
