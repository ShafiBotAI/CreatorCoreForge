import XCTest
@testable import CreatorCoreForge

final class VideoExportServiceTests: XCTestCase {
    func testExportVideoMP4CreatesFile() {
        let service = VideoExportService()
        let url = service.exportVideoMP4(frames: ["f1", "f2"])
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
    }

    func testExportVideoMP4WithMetadataCreatesSidecar() {
        let service = VideoExportService()
        let meta = VideoMetadata(title: "Test", description: "desc", tags: ["a"], duration: 1.0)
        let url = service.exportVideoMP4(frames: ["f1"], metadata: meta)
        let metaURL = url.deletingPathExtension().appendingPathExtension("json")
        XCTAssertTrue(FileManager.default.fileExists(atPath: metaURL.path))
    }
}
