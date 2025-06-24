import XCTest
@testable import CreatorCoreForge

final class CustomCodeInjectorTests: XCTestCase {
    func testReplacePlugin() {
        let injector = CustomCodeInjector()
        let plugin = injector.plugin(from: "replace:foo=bar") as? CodePlugin
        XCTAssertNotNil(plugin)
        XCTAssertEqual(plugin?.processPrompt("foo"), "bar")
    }
}
