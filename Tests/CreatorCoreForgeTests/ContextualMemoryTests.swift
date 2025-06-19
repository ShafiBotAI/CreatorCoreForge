import XCTest
@testable import CreatorCoreForge

final class ContextualMemoryTests: XCTestCase {
    func testAddAndContext() {
        let memory = ContextualMemory(limit: 2)
        memory.add(prompt: "Hi", response: "Hello")
        memory.add(prompt: "How are you?", response: "Good")
        XCTAssertTrue(memory.contextString().contains("Hi"))
        XCTAssertTrue(memory.contextString().contains("Good"))
    }

    func testLimit() {
        let memory = ContextualMemory(limit: 1)
        memory.add(prompt: "A", response: "1")
        memory.add(prompt: "B", response: "2")
        let context = memory.contextString()
        XCTAssertFalse(context.contains("Q: A"))
        XCTAssertTrue(context.contains("Q: B"))
    }
}
