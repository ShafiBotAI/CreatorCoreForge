import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import DataForgeAI

final class Feature101to110Tests: XCTestCase {
    private class MockProtocol: URLProtocol {
        static var handler: ((URLRequest) -> (HTTPURLResponse, Data))?
        override class func canInit(with request: URLRequest) -> Bool { true }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
        override func startLoading() {
            guard let handler = MockProtocol.handler else { return }
            let (resp, data) = handler(request)
            client?.urlProtocol(self, didReceive: resp, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
        override func stopLoading() {}
    }

    func makeService(returning text: String) -> OpenAIService {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockProtocol.self]
        MockProtocol.handler = { request in
            let resp = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let json = ["choices": [["message": ["content": text]]]]
            let data = try! JSONSerialization.data(withJSONObject: json)
            return (resp, data)
        }
        let session = URLSession(configuration: config)
        return OpenAIService(apiKey: "TEST", session: session, retries: 0)
    }

    func testEmailCopilotToneAndProduct() {
        let service = makeService(returning: "hello")
        let copilot = AIEmailCopilot(service: service)
        let exp = expectation(description: "email")
        let lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        let persona = Persona(industry: "Tech", region: "US")
        copilot.composeIntroEmail(to: lead, persona: persona, tone: "friendly", product: "Widget", industry: nil) { text in
            XCTAssertEqual(text, "hello")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testLeadMinerEnrichmentExtras() {
        let miner = LeadMiner()
        let lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        let enriched = miner.enrichLead(lead)
        XCTAssertEqual(enriched.firmographics["funding"], "$5M")
    }

    func testCRMIntegrationServices() {
        let hub = CRMIntegration(service: .hubSpot)
        let sf = CRMIntegration(service: .salesforce)
        XCTAssertTrue(hub.endpoint.absoluteString.contains("hubapi"))
        XCTAssertTrue(sf.endpoint.absoluteString.contains("salesforce"))
    }
}

