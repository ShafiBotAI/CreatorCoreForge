import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import CreatorCoreForge

final class LibrarySyncTests: XCTestCase {
    private class MockURLProtocol: URLProtocol {
        static var responseData: Data?
        static var status: Int = 200
        override class func canInit(with request: URLRequest) -> Bool { true }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
        override func startLoading() {
            if let data = MockURLProtocol.responseData {
                let response = HTTPURLResponse(url: request.url!, statusCode: MockURLProtocol.status, httpVersion: nil, headerFields: nil)!
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
            } else {
                let response = HTTPURLResponse(url: request.url!, statusCode: MockURLProtocol.status, httpVersion: nil, headerFields: nil)!
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
        override func stopLoading() {}
    }

    func testUploadProgressSuccess() {
        MockURLProtocol.responseData = Data()
        MockURLProtocol.status = 200
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let sync = LibrarySync(session: session)
        let exp = expectation(description: "upload")
        sync.upload(["book": 0.5], userID: "1") { ok in
            XCTAssertTrue(ok)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testFetchProgressReturnsDictionary() {
        let json = try! JSONEncoder().encode(["book": 0.8])
        MockURLProtocol.responseData = json
        MockURLProtocol.status = 200
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        let sync = LibrarySync(session: session)
        let exp = expectation(description: "fetch")
        sync.fetch(userID: "1") { dict in
            XCTAssertEqual(dict?["book"], 0.8)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
