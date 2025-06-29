import XCTest
@testable import TradeMindAI

final class StrategyBundlerTests: XCTestCase {
    func testBundleCreatesCourse() {
        let bundler = StrategyBundler()
        let bundle = bundler.bundle(strategies: ["a", "b"], title: "Test")
        XCTAssertEqual(bundle.title, "Test")
        XCTAssertEqual(bundle.strategies.count, 2)
    }
}
