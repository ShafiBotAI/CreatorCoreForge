import XCTest
@testable import CreatorCoreForge

final class CodeGeneratorTests: XCTestCase {
    func testGeneratesReactComponent() {
        let gen = CodeGenerator()
        let output = gen.generateComponent(named: "MyView", language: .react)
        XCTAssertTrue(output.contains("function MyView"))
        XCTAssertTrue(gen.generateComponent(named: "Klass", language: .swift).contains("class"))
    }

    func testBackendScaffold() {
        let scaffold = BackendScaffolder()
        XCTAssertTrue(scaffold.generate(for: .express).contains("express"))
        XCTAssertTrue(scaffold.generate(for: .fastAPI).contains("FastAPI"))
        XCTAssertTrue(scaffold.generate(for: .firebase).contains("helloWorld"))
    }
}
