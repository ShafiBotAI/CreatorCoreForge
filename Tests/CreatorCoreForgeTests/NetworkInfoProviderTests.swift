import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import CreatorCoreForge

final class NetworkInfoProviderTests: XCTestCase {
    private class MockURLProtocol: URLProtocol {
        static var responseData: Data?
        static var statusCode: Int = 200
        override class func canInit(with request: URLRequest) -> Bool { true }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
        override func startLoading() {
            if let data = Self.responseData {
                let response = HTTPURLResponse(url: request.url!, statusCode: Self.statusCode, httpVersion: nil, headerFields: nil)!
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
        override func stopLoading() {
            client?.urlProtocolDidFinishLoading(self)
        }
    }

    func testFetchInfoSuccess() {
        let json = "{\"key\":\"value\"}".data(using: .utf8)
        MockURLProtocol.responseData = json
        MockURLProtocol.statusCode = 200
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let provider = NetworkInfoProvider(session: session)
        let exp = expectation(description: "info")
        provider.fetchInfo(from: URL(string: "https://example.com/info")!) { info in
            XCTAssertEqual(info?["key"], "value")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testFetchInfoFailure() {
        MockURLProtocol.responseData = nil
        MockURLProtocol.statusCode = 500
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let provider = NetworkInfoProvider(session: session)
        let exp = expectation(description: "info")
        provider.fetchInfo(from: URL(string: "https://example.com/info")!) { info in
            XCTAssertNil(info)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
