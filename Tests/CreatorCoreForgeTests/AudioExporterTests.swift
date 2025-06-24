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

    func testExportMultitrackOptionsExcludeLayers() {
        let exporter = AudioExporter()
        let voice = Data([0x00])
        let ambient = Data([0x01])
        let fx = Data([0x02])
        let options = ExportOptions(includeAmbient: false, includeFX: false)
        let path = exporter.exportMultitrack(voice: voice,
                                             ambient: ambient,
                                             fx: fx,
                                             baseName: "mix",
                                             options: options)
        XCTAssertNotNil(path)
        let base = FileManager.default.temporaryDirectory.appendingPathComponent("exports")
        XCTAssertFalse(FileManager.default.fileExists(atPath: base.appendingPathComponent("mix_ambient.wav").path))
        XCTAssertFalse(FileManager.default.fileExists(atPath: base.appendingPathComponent("mix_fx.wav").path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: base.appendingPathComponent("mix_voice.wav").path))
    }
}
