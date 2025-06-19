import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import TradeMindAI

final class AutoUpdateManagerTests: XCTestCase {
    private class MockURLProtocol: URLProtocol {
        static var responseData: Data?
        override class func canInit(with request: URLRequest) -> Bool { true }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
        override func startLoading() {
            if let data = MockURLProtocol.responseData {
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
        override func stopLoading() {}
    }

    func testAutoUpdateWrapperReturnsLatestVersion() {
        let json = "{\"version\":\"3.0\"}".data(using: .utf8)
        MockURLProtocol.responseData = json
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        let expectation = XCTestExpectation(description: "update")
        AutoUpdateManager.checkForUpdate(currentVersion: "2.0", session: session) { version in
            XCTAssertEqual(version, "3.0")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
