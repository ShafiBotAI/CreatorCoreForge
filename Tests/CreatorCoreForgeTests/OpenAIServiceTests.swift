import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import CreatorCoreForge

final class OpenAIServiceTests: XCTestCase {
    func testPromptFailureWithoutKey() {
        // environment not set should trigger precondition failure
        // Skip test if running in environment with key set
        guard ProcessInfo.processInfo.environment["OPENAI_API_KEY"] == nil else {
            return
        }
        let expectation = XCTestExpectation(description: "failure")
        let service = OpenAIService(apiKey: "TEST", session: URLSession(configuration: .ephemeral), retries: 0)
        service.sendPrompt("hi") { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
