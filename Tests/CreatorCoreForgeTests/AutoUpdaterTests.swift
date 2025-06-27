import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import CreatorCoreForge

final class AutoUpdaterTests: XCTestCase {
    // Simple URL protocol to stub network responses
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
        override func stopLoading() {
            client?.urlProtocolDidFinishLoading(self)
        }
    }

    func testCheckForUpdateReturnsNewVersion() {
        let json = "{\"version\":\"2.0\"}".data(using: .utf8)
        MockURLProtocol.responseData = json
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let updater = AutoUpdater(updateURL: URL(string: "https://example.com")!, session: session)

        let expectation = XCTestExpectation(description: "update")
        updater.checkForUpdate(currentVersion: "1.0") { version in
            XCTAssertEqual(version, "2.0")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
