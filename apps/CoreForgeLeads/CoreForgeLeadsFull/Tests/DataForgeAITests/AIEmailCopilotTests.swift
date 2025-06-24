import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import DataForgeAI

final class AIEmailCopilotTests: XCTestCase {
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

    func makeService(returning text: String) -> OpenAIService {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockProtocol.self]
        MockProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let json = ["choices": [["message": ["content": text]]]]
            let data = try! JSONSerialization.data(withJSONObject: json)
            return (response, data)
        }
        let session = URLSession(configuration: config)
        return OpenAIService(apiKey: "TEST", session: session, retries: 0)
    }

    func testComposeIntroEmail() {
        let service = makeService(returning: "hello")
        let copilot = AIEmailCopilot(service: service)
        let exp = expectation(description: "email")
        let lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        let persona = Persona(industry: "Tech", region: "US")
        copilot.composeIntroEmail(to: lead, persona: persona) { text in
            XCTAssertEqual(text, "hello")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testComposeFollowUpsCount() {
        let service = makeService(returning: "hi")
        let copilot = AIEmailCopilot(service: service)
        let exp = expectation(description: "emails")
        let lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        let persona = Persona(industry: "Tech", region: "US")
        copilot.composeFollowUps(to: lead, persona: persona, count: 2) { emails in
            XCTAssertEqual(emails.count, 2)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
