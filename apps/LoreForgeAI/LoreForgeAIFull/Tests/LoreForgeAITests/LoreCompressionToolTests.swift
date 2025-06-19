import XCTest
@testable import LoreForgeAI

final class LoreCompressionToolTests: XCTestCase {
    func testCompressionWithoutService() {
        let tool = LoreCompressionTool()
        let text = "One. Two. Three. Four. Five."
        let expectation = XCTestExpectation(description: "summary")
        tool.compress(lore: text, sentences: 2) { summary in
            XCTAssertEqual(summary, "One. Two.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
