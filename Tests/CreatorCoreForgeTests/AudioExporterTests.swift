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

    func testCompressCreatesZipPath() {
        let exporter = AudioExporter()
        let zipPath = exporter.compressToZip(filePaths: ["a", "b"], zipName: "bundle")
        XCTAssertTrue(zipPath.hasSuffix("bundle.zip"))
    }
}
