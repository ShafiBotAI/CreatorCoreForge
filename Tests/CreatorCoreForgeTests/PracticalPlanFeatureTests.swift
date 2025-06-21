import XCTest
@testable import CreatorCoreForge

final class PracticalPlanFeatureTests: XCTestCase {
    func testStoryboardImporter() {
        let importer = StoryboardImporter()
        let scenes = importer.importStoryboard("A\nB")
        XCTAssertEqual(scenes, ["A", "B"])
    }

    func testSceneSegmenter() {
        let seg = SceneSegmenter()
        let shots = seg.segments(from: "a. b.")
        XCTAssertEqual(shots, ["a", "b"])
    }

    func testStyleEngine() {
        let engine = StyleEngine()
        XCTAssertEqual(engine.apply(style: .anime, to: "f"), "f-anime")
    }

    func testFrameRenderer() {
        let renderer = FrameRenderer()
        let clip = renderer.render(frames: ["f1", "f2"])
        XCTAssertEqual(clip.frames.count, 2)
    }

    func testOutlineGenerator() {
        let gen = OutlineGenerator()
        let outline = gen.generate(from: "A\n\nB")
        XCTAssertEqual(outline, ["A", "B"])
    }

    func testWorldMemoryService() {
        let svc = WorldMemoryService()
        svc.remember(key: "city", value: "Neo")
        XCTAssertEqual(svc.recall(key: "city"), "Neo")
    }

    func testBranchService() {
        let svc = BranchService()
        svc.addBranch(id: "1", text: "A")
        XCTAssertEqual(svc.branch(for: "1"), "A")
    }

    func testExportService() throws {
        let svc = ExportService()
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("t.txt")
        try? FileManager.default.removeItem(at: url)
        try svc.export(text: "hi", to: url)
        let out = try String(contentsOf: url)
        XCTAssertEqual(out, "hi")
    }

    func testMultiTrackEditor() {
        let editor = MultiTrackEditor()
        let mix = editor.mix(tracks: [[1,2],[3]])
        XCTAssertEqual(mix[0], 4)
    }

    func testLiveEnsembleRoom() {
        let room = LiveEnsembleRoom()
        room.post("hello")
        XCTAssertEqual(room.messages.count, 1)
    }

    func testMacroWorkflowEngine() {
        let engine = MacroWorkflowEngine()
        engine.record("tap")
        XCTAssertEqual(engine.replay(), ["tap"])
    }

    func testExportProduction() {
        let export = ExportProduction()
        let frames = export.export(frames: ["f"], watermark: "wm")
        XCTAssertEqual(frames.first, "f-wm(wm)")
    }
}
