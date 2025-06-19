import XCTest
@testable import CreatorCoreForge

final class LocalAIEngineProTests: XCTestCase {
    func testPromptReversal() {
        let engine = LocalAIEnginePro()
        let expectation = XCTestExpectation(description: "reverse")
        engine.sendPrompt("abc") { result in
            switch result {
            case .success(let text):
                XCTAssertEqual(text, "cba")
            case .failure:
                XCTFail("Unexpected failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testEmbeddingOutput() {
        let engine = LocalAIEnginePro()
        let expectation = XCTestExpectation(description: "embed")
        engine.sendEmbeddingRequest(text: "A") { result in
            switch result {
            case .success(let vector):
                XCTAssertEqual(vector.count, 1)
                XCTAssertEqual(vector[0], Double(Character("A").asciiValue!) / 255.0)
            case .failure:
                XCTFail("Unexpected failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
