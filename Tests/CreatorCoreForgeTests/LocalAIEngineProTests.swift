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

    func testSummarizePrefersKeywordDenseSentence() {
        let engine = LocalAIEnginePro()
        let expectation = XCTestExpectation(description: "summary")
        let text = "The cat is on the mat. Cats chase mice in gardens." // second sentence has more keywords
        engine.summarize(text) { result in
            switch result {
            case .success(let summary):
                XCTAssertEqual(summary, "Cats chase mice in gardens")
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
