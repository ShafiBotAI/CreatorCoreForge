import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import CreatorCoreForge

final class ElevenLabsClientAdvancedTests: XCTestCase {
    private class MockURLProtocol: URLProtocol {
        static var lastRequest: URLRequest?
        static var responseData: Data?
        override class func canInit(with request: URLRequest) -> Bool { true }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
        override func startLoading() {
            Self.lastRequest = request
            if let data = Self.responseData {
                let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
        override func stopLoading() {}
    }

    func testAdvancedSynthesisPayloadIncludesOptions() throws {
        let options = ElevenLabsClient.Options(stability: 0.55, similarityBoost: 0.85, modelID: "test-model")
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        MockURLProtocol.responseData = Data("ok".utf8)
        let client = ElevenLabsClient(apiKey: "TEST", session: session)
        let exp = expectation(description: "tts")
        client.synthesize(text: "Hello", voiceID: "voice", options: options) { _ in
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)

        guard let body = MockURLProtocol.lastRequest?.httpBody else {
            XCTFail("Missing body"); return
        }
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: body) as? [String: Any])
        let settings = json["voice_settings"] as? [String: Double]
        XCTAssertEqual(settings?["stability"] ?? -1, 0.55, accuracy: 0.001)
        XCTAssertEqual(settings?["similarity_boost"] ?? -1, 0.85, accuracy: 0.001)
        XCTAssertEqual(json["model_id"] as? String, "test-model")
    }
}
