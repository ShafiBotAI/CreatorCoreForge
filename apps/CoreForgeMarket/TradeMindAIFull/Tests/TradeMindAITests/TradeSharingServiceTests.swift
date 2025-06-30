import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import TradeMindAI

final class TradeSharingServiceTests: XCTestCase {
    func testShareReturnsPlatforms() {
        class MockProtocol: URLProtocol {
            static var requestHandler: ((URLRequest) -> (HTTPURLResponse, Data))?
            override class func canInit(with request: URLRequest) -> Bool { true }
            override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
            override func startLoading() {
                guard let handler = MockProtocol.requestHandler else { return }
                let (response, data) = handler(request)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            }
            override func stopLoading() {}
        }

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockProtocol.self]
        let session = URLSession(configuration: config)
        MockProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        let hooks: [SharingPlatform: URL] = [
            .telegram: URL(string: "https://example.com/tg")!,
            .discord: URL(string: "https://example.com/dc")!
        ]
        let service = TradeSharingService(session: session, webhooks: hooks)
        let result = service.share(message: "test", to: [.telegram, .discord])
        XCTAssertEqual(Set(result), Set([.telegram, .discord]))
    }
}
