import XCTest
@testable import CreatorCoreForge

final class PluginDependencyGraphTests: XCTestCase {
    func testGraphStoresDependencies() {
        var graph = PluginDependencyGraph()
        graph.addPlugin("A", dependencies: ["B", "C"])
        XCTAssertEqual(graph.dependencies(for: "A"), ["B", "C"])
        XCTAssertTrue(graph.description().contains("A -> B,C"))
    }
}
