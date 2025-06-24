import XCTest
@testable import CreatorCoreForge

final class AudioVisualPhaseOneTests: XCTestCase {
    func testBookImporter() async throws {
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent("book.txt")
        try "Chapter 1\nHello".write(to: tmp, atomically: true, encoding: .utf8)
        let chapters = try await BookImporter.importBook(from: tmp)
        XCTAssertEqual(chapters.count, 1)
    }

    func testBookImporterEPUB() async throws {
        let fm = FileManager.default
        let dir = fm.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let meta = dir.appendingPathComponent("META-INF", isDirectory: true)
        let ops = dir.appendingPathComponent("OPS", isDirectory: true)
        try fm.createDirectory(at: meta, withIntermediateDirectories: true)
        try fm.createDirectory(at: ops, withIntermediateDirectories: true)
        let containerXML = "<?xml version=\"1.0\"?>\n<container version=\"1.0\" xmlns=\"urn:oasis:names:tc:opendocument:xmlns:container\">\n<rootfiles><rootfile full-path=\"OPS/content.opf\" media-type=\"application/oebps-package+xml\"/></rootfiles>\n</container>"
        try containerXML.write(to: meta.appendingPathComponent("container.xml"), atomically: true, encoding: .utf8)
        let opf = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><package version=\"3.0\" xmlns=\"http://www.idpf.org/2007/opf\"><manifest><item id=\"c1\" href=\"chapter1.xhtml\" media-type=\"application/xhtml+xml\"/></manifest><spine><itemref idref=\"c1\"/></spine></package>"
        try opf.write(to: ops.appendingPathComponent("content.opf"), atomically: true, encoding: .utf8)
        let chapter = "<html xmlns=\"http://www.w3.org/1999/xhtml\"><body><h1>Chapter 1</h1><p>Hello world</p></body></html>"
        try chapter.write(to: ops.appendingPathComponent("chapter1.xhtml"), atomically: true, encoding: .utf8)
        let epubURL = fm.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".epub")
        let cwd = fm.currentDirectoryPath
        fm.changeCurrentDirectoryPath(dir.path)
        defer { fm.changeCurrentDirectoryPath(cwd); try? fm.removeItem(at: dir) }
        _ = ProcessInfo.processInfo
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/zip")
        proc.arguments = ["-qr", epubURL.path, "META-INF", "OPS"]
        try proc.run()
        proc.waitUntilExit()
        let chapters = try await BookImporter.importBook(from: epubURL)
        XCTAssertEqual(chapters.count, 1)
        XCTAssertTrue(chapters[0].text.contains("Hello world"))
    }

    func testSegmentServiceAndTTS() {
        let chapters = [Chapter(title: "C1", text: "A\n\nB")]
        let segs = SegmentService().segment(chapters)
        XCTAssertEqual(segs.count, 2)
        let tts = TTSService()
        let blob = tts.renderSegment(segs[0], voiceId: "v1")
        XCTAssertTrue(String(data: blob, encoding: .utf8)?.contains("voice:v1") ?? false)
    }

    func testSegmentServiceAsync() async {
        let chapters = [Chapter(title: "C1", text: "A\n\nB\n\nC")]
        let expectation = XCTestExpectation(description: "async segments")
        SegmentService().segmentAsync(chapters) { segs in
            XCTAssertEqual(segs.count, 3)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1)
    }

    func testSegmentServiceAsyncChunked() async {
        let chapters = [
            Chapter(title: "C1", text: "A\n\nB"),
            Chapter(title: "C2", text: "C\n\nD")
        ]
        let segs = await SegmentService().segmentAsyncChunked(chapters, chunkSize: 1)
        XCTAssertEqual(segs.count, 4)
    }

    func testStreamAssembler() {
        let a = Data([0,1])
        let b = Data([2])
        let out = StreamAssembler().assemble([a,b])
        XCTAssertEqual(out, Data([0,1,2]))
    }

    func testNSFWService() {
        let svc = NSFWService()
        XCTAssertTrue(svc.flag(text: "explicit sex scene"))
        XCTAssertFalse(svc.flag(text: "hello"))
    }

    func testTimelineEditor() {
        let editor = TimelineEditor<String>()
        editor.addClip("a")
        XCTAssertEqual(editor.timeline(), ["a"])
    }

    func testStoryboardPanel() {
        var panel = StoryboardPanel()
        panel.addScene("s1")
        panel.addScene("s2")
        panel.moveScene(from: 0, to: 1)
        XCTAssertEqual(panel.list(), ["s2", "s1"])
    }
}

