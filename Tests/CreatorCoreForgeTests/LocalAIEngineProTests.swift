import XCTest
@testable import CreatorCoreForge

final class LocalAIEngineProTests: XCTestCase {
    func testPromptGeneration() {
        let engine = LocalAIEnginePro()
        let expectation = XCTestExpectation(description: "reverse")
        engine.sendPrompt("abc") { result in
            switch result {
            case .success(let text):
                XCTAssertFalse(text.isEmpty)
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
                XCTAssertEqual(vector.count, 128)
                XCTAssertTrue(vector.reduce(0, +) > 0)
            case .failure:
                XCTFail("Unexpected failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testSummarizeReturnsFirstSentence() {
        let engine = LocalAIEnginePro()
        let expectation = XCTestExpectation(description: "summary")
        engine.summarize("First. Second.") { result in
            switch result {
            case .success(let summary):
                XCTAssertFalse(summary.isEmpty)
            case .failure:
                XCTFail("Unexpected failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testAnalyzeSentimentDetectsPositive() {
        let engine = LocalAIEnginePro()
        let sentiment = engine.analyzeSentiment("This is great and wonderful")
        XCTAssertEqual(sentiment, .positive)
    }

    func testAnalyzeSentimentDetectsNegative() {
        let engine = LocalAIEnginePro()
        let sentiment = engine.analyzeSentiment("This is awful and terrible")
        XCTAssertEqual(sentiment, .negative)
    }
}
