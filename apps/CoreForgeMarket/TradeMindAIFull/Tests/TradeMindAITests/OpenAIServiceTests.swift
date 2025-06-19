import XCTest
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import TradeMindAI

final class OpenAIServiceTests: XCTestCase {
    func testLoadTemplates() {
        let bundle = Bundle.module
        let loader = PromptTemplateLoader(bundle: bundle)
        let templates = loader.loadTemplates()
        XCTAssertFalse(templates.isEmpty)
    }
}

final class OpenAIServiceIntegrationTests: XCTestCase {
    func testSendPromptMock() {
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
            let json = ["choices": [["message": ["content": "test"]]]]
            let data = try! JSONSerialization.data(withJSONObject: json)
            return (response, data)
        }

        let service = OpenAIService(apiKey: "TEST", session: session, retries: 0)
        let exp = expectation(description: "response")
        service.sendPrompt("hi") { result in
            switch result {
            case .success(let str):
                XCTAssertEqual(str, "test")
            case .failure(let err):
                XCTFail("Unexpected error: \(err)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testFetchEmbeddingMock() {
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

        let embeddingJSON = ["data": [["embedding": [0.1, 0.2, 0.3]]]]
        MockProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = try! JSONSerialization.data(withJSONObject: embeddingJSON)
            return (response, data)
        }

        let service = OpenAIService(apiKey: "TEST", session: session, retries: 0)
        let exp = expectation(description: "embedding")
        service.fetchEmbedding(for: "hello") { result in
            switch result {
            case .success(let arr):
                XCTAssertEqual(arr, [0.1, 0.2, 0.3])
            case .failure(let err):
                XCTFail("Unexpected error: \(err)")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
