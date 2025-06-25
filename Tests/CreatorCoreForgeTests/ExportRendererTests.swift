import XCTest
@testable import CreatorCoreForge

final class ExportRendererTests: XCTestCase {
    func testExportCreatesFile() {
        let renderer = ExportRenderer()
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("v.mp4")
        try? Data().write(to: url)
        let out = renderer.export(video: url, resolution: .p720)
        XCTAssertTrue(FileManager.default.fileExists(atPath: out.path))
    }
}
