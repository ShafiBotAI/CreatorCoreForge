import XCTest
@testable import CreatorCoreForge

final class AudioExporterTests: XCTestCase {
    func testMP3ExportWritesFile() {
        let exporter = AudioExporter()
        let data = "test".data(using: .utf8)!
        XCTAssertTrue(exporter.exportToMP3(audioData: data, filename: "sample"))
    }

    func testWAVExportWritesFile() {
        let exporter = AudioExporter()
        let data = Data(count: 4)
        XCTAssertTrue(exporter.exportToWAV(audioData: data, filename: "sample"))
    }

    func testFLACExportWithMetadata() {
        let exporter = AudioExporter()
        let data = Data(count: 4)
        let meta = AudioMetadata(narrator: "n", chapter: 1, genre: "g", fx: "f")
        XCTAssertTrue(exporter.exportToFLAC(audioData: data, filename: "track", metadata: meta))
    }

    func testPreviewFileSizeReturnsValue() {
        let exporter = AudioExporter()
        let data = Data(count: 1024)
        XCTAssertGreaterThan(exporter.previewFileSize(for: data, format: "mp3"), 0)
    }

    func testCompressCreatesZipPath() {
        let exporter = AudioExporter()
        let zipPath = exporter.compressToZip(filePaths: ["a", "b"], zipName: "bundle")
        XCTAssertTrue(zipPath.hasSuffix("bundle.zip"))
    }
}
