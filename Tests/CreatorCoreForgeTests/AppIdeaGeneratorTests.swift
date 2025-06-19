import XCTest
@testable import CreatorCoreForge

final class AppIdeaGeneratorTests: XCTestCase {
    func testCustomTopicGeneration() {
        let generator = AppIdeaGenerator(topics: ["Cats"])
        let idea = generator.generateIdea()
        XCTAssertEqual(idea, "Cats Helper")
    }

    func testDefaultTopicsNotEmpty() {
        let generator = AppIdeaGenerator()
        XCTAssertFalse(generator.topics.isEmpty)
    }
}
