import XCTest
@testable import CreatorCoreForge

final class QuantumEditModeTests: XCTestCase {
    func testBranchEdits() {
        let mode = QuantumEditMode()
        XCTAssertEqual(mode.branch(edits: ["cut"]), ["cut", "cut"])
    }
}
