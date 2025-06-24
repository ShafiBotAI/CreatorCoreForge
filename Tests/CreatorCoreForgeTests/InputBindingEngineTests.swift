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

    func testComputedWatcherUpdates() {
        let engine = InputBindingEngine()
        engine.bindComputed(field: "full") { vals in
            (vals["first"] ?? "") + (vals["last"] ?? "")
        }
        engine.bind(field: "first", value: "A")
        engine.bind(field: "last", value: "B")
        XCTAssertEqual(engine.value(for: "full"), "AB")
    }

    func testWatcherCallbackRuns() {
        let engine = InputBindingEngine()
        var captured = ""
        engine.addWatcher(for: "name") { captured = $0 }
        engine.bind(field: "name", value: "Jane")
        XCTAssertEqual(captured, "Jane")
    }
}
