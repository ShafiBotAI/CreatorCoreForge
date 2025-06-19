import XCTest
@testable import VerseForgeAI

final class HookCrafterTests: XCTestCase {
    func testRankHooksReturnsSorted() {
        let crafter = HookCrafter()
        let hooks = ["hook1", "hook2", "hook3"]
        let ranked = crafter.rankHooks(hooks)
        XCTAssertEqual(ranked.count, 3)
        XCTAssertTrue(ranked[0].score >= ranked[1].score)
    }
}
