import XCTest
@testable import CreatorCoreForge

final class FusionEngineTests: XCTestCase {
    func testLocalModeUsesLocalEngine() {
        let engine = FusionEngine(mode: .local)
        let expect = XCTestExpectation(description: "local")
        engine.sendPrompt("hello") { result in
            if case .success(let text) = result {
                XCTAssertFalse(text.isEmpty)
            } else {
                XCTFail("Failed to use local engine")
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1)
    }
}
