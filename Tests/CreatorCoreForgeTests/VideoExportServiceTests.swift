import XCTest
@testable import CreatorCoreForge

final class VideoExportServiceTests: XCTestCase {
    func testExportVideoMP4CreatesFile() {
        let service = VideoExportService()
        let url = service.exportVideoMP4(frames: ["f1", "f2"])
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))
    }
}
