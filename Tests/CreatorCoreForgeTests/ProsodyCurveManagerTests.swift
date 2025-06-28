import XCTest
@testable import CreatorCoreForge

final class ProsodyCurveManagerTests: XCTestCase {
    func testCurveType() {
        let manager = ProsodyCurveManager()
        XCTAssertEqual(manager.curveType(for: "Is this working?"), "rise")
        XCTAssertEqual(manager.curveType(for: "Amazing!"), "burst")
        XCTAssertEqual(manager.curveType(for: "Just a line."), "fall")
    }

    func testStressIndices() {
        let manager = ProsodyCurveManager()
        let indices = manager.stressIndices(in: "This is *really* IMPORTANT text")
        XCTAssertTrue(indices.contains(2))
        XCTAssertTrue(indices.contains(3))
    }
}
