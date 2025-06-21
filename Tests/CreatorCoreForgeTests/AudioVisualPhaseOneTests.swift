import XCTest
@testable import CreatorCoreForge

final class AudioVisualPhaseOneTests: XCTestCase {
    func testBookImporter() throws {
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent("book.txt")
        try "Title: Sample\nAuthor: A\nChapter 1\nHello".write(to: tmp, atomically: true, encoding: .utf8)
        let importer = BookImporter()
        let book = try importer.import(fileURL: tmp)
        XCTAssertEqual(book.title, "Sample")
        XCTAssertEqual(book.author, "A")
        XCTAssertEqual(book.chapters.count, 1)
    }

    func testSegmentServiceAndTTS() {
        let chapters = [Chapter(title: "C1", text: "A\n\nB")] 
        let segs = SegmentService().segment(chapters)
        XCTAssertEqual(segs.count, 2)
        let tts = TTSService()
        let blob = tts.renderSegment(segs[0], voiceId: "v1")
        XCTAssertTrue(String(data: blob, encoding: .utf8)?.contains("voice:v1") ?? false)
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

