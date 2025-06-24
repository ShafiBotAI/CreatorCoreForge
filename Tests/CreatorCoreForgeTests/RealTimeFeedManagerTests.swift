import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import CreatorCoreForge

final class RealTimeFeedManagerTests: XCTestCase {
    private class MockURLProtocol: URLProtocol {
        static var responseData: Data?
        static var fail: Bool = false
        override class func canInit(with request: URLRequest) -> Bool { true }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
        override func startLoading() {
            if Self.fail {
                client?.urlProtocol(self, didFailWithError: URLError(.badServerResponse))
            } else {
                if let data = Self.responseData {
                    let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                    client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                    client?.urlProtocol(self, didLoad: data)
                }
                client?.urlProtocolDidFinishLoading(self)
            }
        }
        override func stopLoading() {
            client?.urlProtocolDidFinishLoading(self)
        }
    }

    func testFetchFeedFromNetwork() {
        let json = "[\"News\",\"Anime\"]".data(using: .utf8)
        MockURLProtocol.responseData = json
        MockURLProtocol.fail = false
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let store = FileManager.default.temporaryDirectory.appendingPathComponent("feed.json")
        let manager = RealTimeFeedManager(offlineStore: store, session: session)
        let exp = expectation(description: "feed")
        manager.fetchFeed(from: URL(string: "https://example.com/feed")!) { feed in
            XCTAssertEqual(feed, ["News","Anime"])
            XCTAssertTrue(FileManager.default.fileExists(atPath: store.path))
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testFetchFeedFallbackToOffline() {
        let cached = "[\"Offline\"]".data(using: .utf8)!
        let store = FileManager.default.temporaryDirectory.appendingPathComponent("feed2.json")
        try? cached.write(to: store)
        MockURLProtocol.responseData = nil
        MockURLProtocol.fail = true
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let manager = RealTimeFeedManager(offlineStore: store, session: session)
        let exp = expectation(description: "feed")
        manager.fetchFeed(from: URL(string: "https://example.com/feed")!) { feed in
            XCTAssertEqual(feed, ["Offline"])
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
