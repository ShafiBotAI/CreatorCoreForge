import XCTest
@testable import CreatorCoreForge

final class BuildBridgeTests: XCTestCase {
    func testBridgeFixesMissingCode() throws {
        let dir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        let file = dir.appendingPathComponent("Sample.swift")
        try "func demo() { fatalError(\"Not implemented\") }".write(to: file, atomically: true, encoding: .utf8)
        let bridge = BuildBridge()
        XCTAssertEqual(bridge.fix(path: dir.path), 1)
        let updated = try String(contentsOf: file)
        XCTAssertTrue(updated.contains("// TODO: implement"))
    }
}
