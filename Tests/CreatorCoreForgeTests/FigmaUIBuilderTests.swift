import XCTest
@testable import CreatorCoreForge

final class FigmaUIBuilderTests: XCTestCase {
    func testGenerateViews() {
        let json = "{\"nodes\":[{\"name\":\"Button\"},{\"name\":\"Label\"}]}"
        let builder = FigmaUIBuilder()
        XCTAssertEqual(builder.generateViews(from: json), ["Button", "Label"])
    }
}
