import XCTest
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import TradeMindAI

final class AdminServiceTests: XCTestCase {
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

    func makeService(json: String) -> AdminService {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockProtocol.self]
        let session = URLSession(configuration: config)
        MockProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, json.data(using: .utf8)!)
        }
        return AdminService(baseURL: URL(string: "https://example.com")!, session: session)
    }

    func testGetQuotasReturnsDecodedData() {
        let json = "[{\"userId\":\"u1\",\"limit\":1}]"
        let service = makeService(json: json)
        let exp = expectation(description: "quotas")
        service.getQuotas { result in
            switch result {
            case .success(let quotas):
                XCTAssertEqual(quotas, [Quota(userId: "u1", limit: 1)])
            case .failure(let err):
                XCTFail("Unexpected error: \(err)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testUpdateQuotaSendsPut() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockProtocol.self]
        let session = URLSession(configuration: config)
        var receivedMethod: String?
        var receivedBody: Data?
        MockProtocol.requestHandler = { request in
            receivedMethod = request.httpMethod
            receivedBody = request.httpBody
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        let service = AdminService(baseURL: URL(string: "https://example.com")!, session: session)
        let quota = Quota(userId: "u1", limit: 5)
        let exp = expectation(description: "update")
        service.updateQuota(userId: "u1", newQuota: quota) { result in
            if case .failure(let err) = result { XCTFail("Unexpected: \(err)") }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(receivedMethod, "PUT")
        let decoded = try? JSONDecoder().decode(Quota.self, from: receivedBody ?? Data())
        XCTAssertEqual(decoded, quota)
    }
}
