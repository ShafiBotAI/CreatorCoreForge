import XCTest
@testable import CreatorCoreForge

final class MemoryAnchorServiceTests: XCTestCase {
    func testCreateAndLoad() {
        let dir = FileManager.default.temporaryDirectory
        let url = dir.appendingPathComponent("anchors_test.json")
        var service: MemoryAnchorService? = MemoryAnchorService(fileURL: url)
        _ = service?.createAnchor(description: "Scene1")
        service = nil
        service = MemoryAnchorService(fileURL: url)
        XCTAssertEqual(service?.allAnchors().first?.description, "Scene1")
        try? FileManager.default.removeItem(at: url)
    }
}
