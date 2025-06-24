import XCTest
@testable import CreatorCoreForge

final class MemoryPinningTests: XCTestCase {
    func testPinRetrieveAndSummary() {
        let memory = MemoryPinning()
        memory.pinMemory(for: "Nash", event: "confessed", weight: 0.9, permanent: true)
        XCTAssertEqual(memory.getPinned(for: "nash").count, 1)
        let summary = memory.summary(for: "Nash")
        XCTAssertTrue(summary.contains("confessed"))
    }

    func testRemoveAndClear() {
        let memory = MemoryPinning()
        memory.pinMemory(for: "Nash", event: "test")
        guard let id = memory.pinnedMemories.first?.id else {
            XCTFail("Missing pin")
            return
        }
        memory.removePin(id)
        XCTAssertTrue(memory.pinnedMemories.isEmpty)

        memory.pinMemory(for: "Nash", event: "1")
        memory.pinMemory(for: "Nash", event: "2", permanent: true)
        memory.clearTemporaryPins()
        XCTAssertEqual(memory.pinnedMemories.count, 1)
        memory.clearAllPins()
        XCTAssertTrue(memory.pinnedMemories.isEmpty)
    }
}
