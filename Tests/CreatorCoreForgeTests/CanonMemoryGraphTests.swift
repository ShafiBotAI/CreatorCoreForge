import XCTest
@testable import CreatorCoreForge

final class CanonMemoryGraphTests: XCTestCase {
    func testLinkPersistence() {
        let dir = FileManager.default.temporaryDirectory
        let url = dir.appendingPathComponent("graph_test.json")
        var graph: CanonMemoryGraph? = CanonMemoryGraph(fileURL: url)
        let a = CanonMemoryGraph.Node(id: "A")
        let b = CanonMemoryGraph.Node(id: "B")
        graph?.link(a, b)
        graph = nil
        graph = CanonMemoryGraph(fileURL: url)
        XCTAssertEqual(graph?.links(for: a), [b])
        try? FileManager.default.removeItem(at: url)
    }
}
