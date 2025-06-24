import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import CreatorCoreForge

final class SocialMediaManagerTests: XCTestCase {
    private class MockURLProtocol: URLProtocol {
        static var statusCode: Int = 200
        override class func canInit(with request: URLRequest) -> Bool { true }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
        override func startLoading() {
            let response = HTTPURLResponse(url: request.url!, statusCode: Self.statusCode, httpVersion: nil, headerFields: nil)!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
        }
        override func stopLoading() {
            client?.urlProtocolDidFinishLoading(self)
        }
    }

    func testPostUpdateSuccess() {
        MockURLProtocol.statusCode = 200
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let manager = SocialMediaManager(session: URLSession(configuration: config))
        let exp = expectation(description: "post")
        manager.postUpdate("hello", to: URL(string: "https://example.com")!, token: "t") { success in
            XCTAssertTrue(success)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testPostUpdateFailure() {
        MockURLProtocol.statusCode = 400
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let manager = SocialMediaManager(session: URLSession(configuration: config))
        let exp = expectation(description: "post")
        manager.postUpdate("fail", to: URL(string: "https://example.com")!, token: "t") { success in
            XCTAssertFalse(success)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
