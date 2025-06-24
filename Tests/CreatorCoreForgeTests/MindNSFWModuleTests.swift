import XCTest
@testable import CreatorCoreForge

final class MindNSFWModuleTests: XCTestCase {
    func testSuggestReturnsMood() {
        let module = MindNSFWModule()
        let result = module.suggest(for: "stress")
        XCTAssertTrue(result.contains("stress"))
    }
}
