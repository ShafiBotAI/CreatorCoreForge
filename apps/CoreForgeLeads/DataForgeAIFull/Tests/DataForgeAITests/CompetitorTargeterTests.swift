import XCTest
@testable import DataForgeAI

final class CompetitorTargeterTests: XCTestCase {
    func testMirrorFollowersGeneratesHandles() {
        let targeter = CompetitorTargeter()
        let handles = targeter.mirrorFollowers(of: "Acme Co")
        XCTAssertEqual(handles.count, 5)
        XCTAssertEqual(handles.first, "acmeco_1")
    }
}
