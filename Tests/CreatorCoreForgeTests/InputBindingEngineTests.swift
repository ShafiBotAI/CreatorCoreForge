import XCTest
@testable import CreatorCoreForge

final class InputBindingEngineSimpleTests: XCTestCase {
    func testBindAndRetrieve() {
        let engine = InputBindingEngine()
        engine.bind(field: "name", value: "Bob")
        XCTAssertEqual(engine.value(for: "name"), "Bob")
    }

    func testComputed() {
        let engine = InputBindingEngine()
        engine.bind(field: "a", value: "1")
        engine.bind(field: "b", value: "2")
        let sum = engine.computed("sum") { vals in
            if let a = Int(vals["a"] ?? ""), let b = Int(vals["b"] ?? "") {
                return String(a + b)
            }
            return "0"
        }
        XCTAssertEqual(sum, "3")
    }
}
