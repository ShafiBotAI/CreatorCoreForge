import XCTest
@testable import CreatorCoreForge

final class DAWSessionExporterTests: XCTestCase {
    func testExportSession() throws {
        let exporter = DAWSessionExporter()
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("test.session")
        let data = Data([0])
        try exporter.exportSession(tracks: ["Alice": [data]], to: url)
        let text = try String(contentsOf: url)
        XCTAssertTrue(text.contains("Track: Alice"))
    }
}
