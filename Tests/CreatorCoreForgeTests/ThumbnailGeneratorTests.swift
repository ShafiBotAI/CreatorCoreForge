import XCTest
@testable import CreatorCoreForge

final class ThumbnailGeneratorTests: XCTestCase {
    func testGenerateThumbnailCreatesFile() {
        let exporter = VideoExportService()
        let videoURL = exporter.exportVideoMP4(frames: ["f1", "f2"])
        let generator = ThumbnailGenerator()
        let thumb = generator.generateThumbnail(for: videoURL)
        XCTAssertTrue(FileManager.default.fileExists(atPath: thumb.path))
    }
}
