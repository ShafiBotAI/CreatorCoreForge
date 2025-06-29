import XCTest
@testable import DataForgeAI

final class Feature91to100Tests: XCTestCase {
    func testLeadsAPIServiceFetch() {
        class MockProtocol: URLProtocol {
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
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockProtocol.self]
        let session = URLSession(configuration: config)
        let service = LeadsAPIService(baseURL: URL(string: "https://test")!, session: session)
        let lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        let data = try! JSONEncoder().encode([lead])
        MockProtocol.handler = { req in
            let resp = HTTPURLResponse(url: req.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (resp, data)
        }
        let exp = expectation(description: "fetch")
        service.fetchLeads(limit: 1) { leads in
            XCTAssertEqual(leads.first?.email, lead.email)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testCampaignCloner() {
        let cloner = CampaignCloner()
        let seq = ["a", "b"]
        XCTAssertEqual(cloner.clone(sequence: seq), seq)
    }

    func testSalesPerformanceAnalytics() {
        let analytics = SalesPerformanceAnalytics()
        let avg = analytics.averageResponseTime([1, 3, 5])
        XCTAssertEqual(avg, 3, accuracy: 0.1)
    }

    func testDuplicateLeadMerger() {
        let lead1 = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        let lead2 = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        let merged = DuplicateLeadMerger().merge([lead1, lead2], threshold: 0.9)
        XCTAssertEqual(merged.count, 1)
    }

    func testGlobalCurrencySupport() {
        let support = GlobalCurrencySupport(locale: Locale(identifier: "en_US"))
        XCTAssertTrue(support.format(amount: 5).contains("$") )
    }

    func testOutreachDelayOptimizer() {
        let now = Date()
        let hist = [now.addingTimeInterval(-3600), now]
        let delay = OutreachDelayOptimizer().recommendedDelay(from: hist)
        XCTAssertEqual(delay, 3600, accuracy: 0.1)
    }

    func testDFScoreHeatmap() {
        let heat = DFScoreHeatmap().heatmap(scores: [[1,2],[3,4]])
        XCTAssertEqual(heat, [2,3])
    }

    func testAICopilotChat() {
        class MockProtocol: URLProtocol {
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
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockProtocol.self]
        let session = URLSession(configuration: config)
        let service = OpenAIService(apiKey: "TEST", session: session, retries: 0)
        let copilot = AICopilotChat(service: service)
        MockProtocol.handler = { req in
            let resp = HTTPURLResponse(url: req.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let json = ["choices": [["message": ["content": "hi"]]]]
            let data = try! JSONSerialization.data(withJSONObject: json)
            return (resp, data)
        }
        let exp = expectation(description: "chat")
        copilot.suggestReply(for: "hello") { text in
            XCTAssertEqual(text, "hi")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testVoiceLeadDictation() {
        let note = "A,a@a.com,Acme,Tech,US"
        let lead = VoiceLeadDictation().parse(note: note)
        XCTAssertEqual(lead?.company, "Acme")
    }

    func testMarketTransferService() {
        class MockProtocol: URLProtocol {
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
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockProtocol.self]
        let session = URLSession(configuration: config)
        let service = MarketTransferService(baseURL: URL(string: "https://t")!, session: session)
        MockProtocol.handler = { req in
            let resp = HTTPURLResponse(url: req.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (resp, Data())
        }
        let exp = expectation(description: "transfer")
        let lead = Lead(name: "A", email: "a@a.com", company: "Acme", industry: "Tech", region: "US")
        service.transfer(lead) { ok in
            XCTAssertTrue(ok)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
