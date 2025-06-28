import XCTest
@testable import CreatorCoreForge

final class AudioImperfectionFilterTests: XCTestCase {
    func testApplyKeepsData() {
        let filter = AudioImperfectionFilter()
        let input = Data([1,2,3])
        let output = filter.apply(to: input)
        XCTAssertFalse(output.isEmpty)
    }
}
