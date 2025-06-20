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
}
