import XCTest
@testable import CreatorCoreForge

final class FusionEnginePluginTests: XCTestCase {
    private struct EchoEngine: AIEngine {
        func sendPrompt(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
            completion(.success(prompt))
        }
        func sendEmbeddingRequest(text: String, completion: @escaping (Result<[Double], Error>) -> Void) {
            completion(.success([]))
        }
        func summarize(_ text: String, completion: @escaping (Result<String, Error>) -> Void) {
            completion(.success(text))
        }
    }

    func testMacroPluginReplacesTokens() {
        let plugin = MacroPlugin(macros: ["$NAME": "Bob"]) 
        let engine = FusionEngine(engine: EchoEngine(), plugins: [plugin])
        let exp = expectation(description: "macro")
        engine.sendPrompt("Hello $NAME") { result in
            if case .success(let text) = result {
                XCTAssertEqual(text, "Hello Bob")
            } else { XCTFail("Bad result") }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
