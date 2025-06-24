import XCTest
@testable import CreatorCoreForge

final class CoreForgeVisualTaskTests: XCTestCase {
    func testCharacterPaletteManager() {
        let manager = CharacterPaletteManager()
        manager.setPalette(for: "Alice", palette: ["red", "blue"])
        XCTAssertEqual(manager.palette(for: "alice"), ["red", "blue"])
    }

    func testLightingRecommender() {
        let rec = LightingRecommender()
        XCTAssertEqual(rec.recommend(for: "happy"), "bright_warm")
        XCTAssertEqual(rec.recommend(for: "unknown"), "neutral")
    }

    func testTimelineVariants() {
        let manager = VisualMultiverseManager()
        manager.clearAll()
        manager.addOutcome(sceneID: "s1", description: "b", frames: [], project: "P")
        manager.addOutcome(sceneID: "s1", description: "a", frames: [], project: "P")
        let variants = manager.timelineVariants(for: "s1", project: "P")
        XCTAssertEqual(variants.map { $0.description }, ["a", "b"])
    }

    func testAnimationDashboard() {
        let dash = AnimationDashboard()
        _ = dash.preview(animation: "walk")
        dash.lockAnimation(for: "Hero")
        XCTAssertTrue(dash.isLocked("hero"))
    }

    func testSceneBackgroundGenerator() {
        let gen = SceneBackgroundGenerator()
        XCTAssertEqual(gen.generateBackground(for: "Fantasy World"), "background-fantasy_world")
    }

    func testLightingConditioner() {
        let cond = LightingConditioner()
        XCTAssertEqual(cond.preset(forTimeOfDay: "Day", tone: "Happy", setting: "Outdoor"), "day_happy_outdoor")
    }

    func testCinematicComposer() {
        let comp = CinematicComposer()
        let frames = comp.compose(characters: ["A", "B"], rule: .ruleOfThirds)
        XCTAssertEqual(frames.first, "A-thirds-0")
    }

    func testVideoEffectsPipelineTransitions() {
        let pipe = VideoEffectsPipeline()
        let result = pipe.applyTransitions(to: ["f1", "f2"], style: "cut")
        XCTAssertEqual(result, ["f1", "cut", "f2"])
    }

    func testParticleFXLayer() {
        let layer = ParticleFXLayer()
        XCTAssertEqual(layer.applyParticles(to: ["f"], type: "rain"), ["f-fx_rain"])
    }

    func testCameraMotionRenderer() {
        let renderer = CameraMotionRenderer()
        XCTAssertEqual(renderer.applyMotion(to: ["f"], motion: .zoom), ["f-zoom"])
    }
}
