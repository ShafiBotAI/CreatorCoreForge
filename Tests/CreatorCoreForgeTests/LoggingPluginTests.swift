import XCTest
@testable import CreatorCoreForge

final class LoggingPluginTests: XCTestCase {
    func testLogsPromptAndResponse() {
        let tempDir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try? FileManager.default.createDirectory(at: tempDir, withIntermediateDirectories: true)
        let logger = AnalyticsLogger(directory: tempDir)
        let plugin = LoggingPlugin(logger: logger)
        let engine = FusionEngine(engine: DummyEngine(), plugins: [plugin])
        let exp = expectation(description: "prompt")
        engine.sendPrompt("Ping") { result in
            if case .success = result {
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
        // Allow async logging to flush
        Thread.sleep(forTimeInterval: 0.1)
        let logPath = tempDir.appendingPathComponent("analytics.log").path
        let log = try? String(contentsOfFile: logPath)
        XCTAssertNotNil(log)
        XCTAssertTrue(log?.contains("Prompt: Ping") ?? false)
        XCTAssertTrue(log?.contains("Response:") ?? false)
    }

    private struct DummyEngine: AIEngine {
        func sendPrompt(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
            completion(.success("Pong"))
        }
        func sendEmbeddingRequest(text: String, completion: @escaping (Result<[Double], Error>) -> Void) {
            completion(.success([]))
        }
        func summarize(_ text: String, completion: @escaping (Result<String, Error>) -> Void) {
            completion(.success("sum"))
        }
    }
}
