import XCTest
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import TradeMindAI

final class ReportingServiceTests: XCTestCase {
    private class MockProtocol: URLProtocol {
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

    func testGenerateUsageReportParsesResponse() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockProtocol.self]
        let session = URLSession(configuration: config)
        let json = "{\"summary\":\"ok\"}"
        MockProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, json.data(using: .utf8)!)
        }
        let service = ReportingService(baseURL: URL(string: "https://example.com")!, session: session)
        let range = DateRange(start: Date(), end: Date())
        let exp = expectation(description: "report")
        service.generateUsageReport(period: range) { result in
            switch result {
            case .success(let report):
                XCTAssertEqual(report, Report(summary: "ok"))
            case .failure(let err):
                XCTFail("Unexpected: \(err)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
