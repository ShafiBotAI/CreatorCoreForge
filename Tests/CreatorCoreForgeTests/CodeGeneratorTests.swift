import XCTest
@testable import CreatorCoreForge

final class CodeGeneratorTests: XCTestCase {
    func testGeneratesReactComponent() {
        let gen = CodeGenerator()
        let output = gen.generateComponent(named: "MyView", language: .react)
        XCTAssertTrue(output.contains("function MyView"))
    }
}
