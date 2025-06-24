import XCTest
@testable import CreatorCoreForge

final class AudiobookCompilerTests: XCTestCase {
    func testCompileCreatesZip() {
        let tmp1 = FileManager.default.temporaryDirectory.appendingPathComponent("a.wav")
        let tmp2 = FileManager.default.temporaryDirectory.appendingPathComponent("b.wav")
        try? "data1".data(using: .utf8)?.write(to: tmp1)
        try? "data2".data(using: .utf8)?.write(to: tmp2)
        let compiler = AudiobookCompiler(exporter: AudioExporter())
        let zipPath = compiler.compile(chapterFiles: [tmp1.path, tmp2.path], name: "book")
        XCTAssertTrue(zipPath.hasSuffix("book.zip"))
    }

    func testCompileAudiobookPackage() {
        let tmp1 = FileManager.default.temporaryDirectory.appendingPathComponent("c1.wav")
        let tmp2 = FileManager.default.temporaryDirectory.appendingPathComponent("c2.wav")
        try? "ch1".data(using: .utf8)?.write(to: tmp1)
        try? "ch2".data(using: .utf8)?.write(to: tmp2)
        let metadata = Metadata(title: "Test", author: "Author")
        let compiler = AudiobookCompiler(exporter: AudioExporter())
        let url = compiler.compileAudiobook(chapters: [tmp1, tmp2], metadata: metadata, cover: nil)
        XCTAssertTrue(url.path.hasSuffix("Test.zip"))
    }
}
