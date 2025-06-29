import XCTest
@testable import CreatorCoreForge

final class NextGenVideoGenerationTests: XCTestCase {
    func testColorGradingEngine() {
        let engine = ColorGradingEngine()
        let out = engine.apply(frame: [[1]], preset: "warm")
        XCTAssertEqual(out, [[1]])
    }

    func testGPUVideoRenderer() {
        let renderer = GPUVideoRenderer()
        let clip = renderer.render(frames: ["f"], options: RendererOptions(width: 1, height: 1))
        XCTAssertEqual(clip.frames, ["f"])
    }

    func testCrowdSimulator() {
        let sim = CrowdSimulator()
        XCTAssertEqual(sim.simulate(count: 2).map { $0.id }, [0, 1])
    }

    func testExport360VR() {
        let data = [Data([0x1])]
        XCTAssertEqual(export360VR(data).count, 1)
    }

    func testCameraStabilizer() {
        let frames = [[[1]]]
        XCTAssertEqual(stabilizeCamera(frames), frames)
    }

    func testBranchingPathsUI() {
        let ui = BranchingPathsUI()
        let output = ui.render(options: [BranchOption(id: "A"), BranchOption(id: "B")])
        XCTAssertEqual(output, ["1. A", "2. B"])
    }
}
