import XCTest
@testable import CreatorCoreForge

final class AccentGeneratorTests: XCTestCase {
    func testApplyAccent() {
        let gen = AccentGenerator()
        let result = gen.applyAccent(.british, to: "Hello")
        XCTAssertEqual(result, "[British] Hello")
    }
}
