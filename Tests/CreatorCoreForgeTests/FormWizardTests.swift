import XCTest
@testable import CreatorCoreForge

final class FormWizardTests: XCTestCase {
    func testStepProgressionWithCondition() {
        let step1 = FormTemplate(name: "one", fields: [FormField(name: "age", type: .number)])
        let step2 = FormTemplate(name: "two", fields: [FormField(name: "name", type: .text)])
        let engine = InputBindingEngine()
        engine.bind(field: "age", value: "20")
        let wizard = FormWizard(steps: [
            FormStep(template: step1),
            FormStep(template: step2, condition: { vals in
                if let a = Int(vals["age"] ?? "") { return a >= 18 }
                return false
            })
        ], binding: engine)
        XCTAssertEqual(wizard.currentStep?.name, "one")
        wizard.next()
        XCTAssertEqual(wizard.currentStep?.name, "two")
    }
}
