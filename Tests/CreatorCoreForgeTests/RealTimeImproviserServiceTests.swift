import XCTest
@testable import CreatorCoreForge

final class RealTimeImproviserServiceTests: XCTestCase {
    private class MockEngine: AIEngine {
        func sendPrompt(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
            completion(.success("Response to: \(prompt)"))
        }
        func sendEmbeddingRequest(text: String, completion: @escaping (Result<[Double], Error>) -> Void) { completion(.success([])) }
        func summarize(_ text: String, completion: @escaping (Result<String, Error>) -> Void) { completion(.success("sum")) }
    }

    func testImproviseReturnsLine() {
        let service = RealTimeImproviserService(engine: FusionEngine(engine: MockEngine()), context: "Scene")
        let exp = expectation(description: "reply")
        service.improvise(userInput: "Hello") { line in
            XCTAssertTrue(line.contains("Hello"))
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testRunSessionMultipleInputs() {
        let service = RealTimeImproviserService(engine: FusionEngine(engine: MockEngine()))
        let exp = expectation(description: "session")
        service.runSession(with: ["A","B"]) { replies in
            XCTAssertEqual(replies.count, 2)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
