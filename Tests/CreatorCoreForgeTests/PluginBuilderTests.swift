import XCTest
@testable import CreatorCoreForge

final class PluginBuilderTests: XCTestCase {
    func testTemplateIncludesNameAndFeature() {
        let builder = PluginBuilder()
        let text = builder.createTemplate(name: "Demo", features: ["Test"])
        XCTAssertTrue(text.contains("Demo"))
        XCTAssertTrue(text.contains("Test"))
    }

    func testIntegratedPluginAddsDocs() {
        let builder = PluginBuilder()
        let text = builder.createIntegratedPlugin(name: "Demo", features: ["A"]) 
        XCTAssertTrue(text.contains("Documentation"))
    }
}
