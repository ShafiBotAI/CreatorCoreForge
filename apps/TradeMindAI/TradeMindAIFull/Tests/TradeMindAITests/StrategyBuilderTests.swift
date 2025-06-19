import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import TradeMindAI

final class StrategyBuilderTests: XCTestCase {
    func testGenerateStrategyMock() {
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
            let json = ["choices": [["message": ["content": "Plan"]]]]
            let data = try! JSONSerialization.data(withJSONObject: json)
            return (response, data)
        }

        let service = OpenAIService(apiKey: "TEST", session: session, retries: 0)
        let builder = StrategyBuilder(service: service)

        let exp = expectation(description: "strategy")
        builder.generateStrategy(from: "Buy dips") { result in
            switch result {
            case .success(let text):
                XCTAssertEqual(text, "Plan")
            case .failure(let err):
                XCTFail("Unexpected error: \(err)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
