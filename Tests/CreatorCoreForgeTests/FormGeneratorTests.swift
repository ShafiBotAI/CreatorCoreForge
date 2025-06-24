import XCTest
@testable import CreatorCoreForge

final class FormGeneratorTests: XCTestCase {
    func testGeneratesLoginForm() {
        let gen = FormGenerator()
        let form = gen.generateForm(from: "Create login form")
        XCTAssertEqual(form?.name, "login")
        XCTAssertEqual(form?.fields.count, 2)
    }

    func testValidation() {
        let gen = FormGenerator()
        let form = gen.generateForm(from: "login")!
        let valid = gen.validate(inputs: ["email": "a", "password": "b"], for: form)
        XCTAssertTrue(valid)
        XCTAssertFalse(gen.validate(inputs: ["email": ""], for: form))
    }
}
