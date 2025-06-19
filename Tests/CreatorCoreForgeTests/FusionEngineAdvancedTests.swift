import XCTest
@testable import CreatorCoreForge

final class FusionEngineAdvancedTests: XCTestCase {
    private struct MockEngine: AIEngine {
        let label: String
        func sendPrompt(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
            completion(.success("\(label):\(prompt)"))
        }
        func sendEmbeddingRequest(text: String, completion: @escaping (Result<[Double], Error>) -> Void) {
            completion(.success([]))
        }
        func summarize(_ text: String, completion: @escaping (Result<String, Error>) -> Void) {
            completion(.success("summary"))
        }
    }

    func testPromptWithMemoryStoresHistory() {
        let engine = FusionEngine(mode: .local)
        let exp = expectation(description: "memory")
        engine.sendPromptWithMemory("hello") { result in
            if case .success(let text) = result {
                XCTAssertEqual(text, "olleh")
                XCTAssertTrue(engine.memory.contextString().contains("hello"))
            } else { XCTFail("fail") }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func testParallelEnginesReturnAllResponses() {
        let m1 = MockEngine(label: "A")
        let m2 = MockEngine(label: "B")
        let engine = FusionEngine(parallelEngines: [m1, m2])
        let exp = expectation(description: "parallel")
        engine.sendPromptParallel("test") { responses in
            XCTAssertEqual(responses.count, 2)
            XCTAssertTrue(responses.contains("A:test"))
            XCTAssertTrue(responses.contains("B:test"))
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
