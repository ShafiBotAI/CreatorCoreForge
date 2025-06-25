import XCTest
@testable import CreatorCoreForge

final class TimelineForkManagerTests: XCTestCase {
    func testBranchStorage() {
        let manager = TimelineForkManager()
        let scene = SceneNode(text: "A", tone: .neutral, characters: [], timestamp: 0)
        manager.add(branch: "A", scenes: [scene])
        XCTAssertEqual(manager.scenes(for: "A").count, 1)
        XCTAssertTrue(manager.allBranches().contains("A"))
    }
}
