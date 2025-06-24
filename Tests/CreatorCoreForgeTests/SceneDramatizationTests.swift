import XCTest
@testable import CreatorCoreForge

final class SceneDramatizationTests: XCTestCase {
    func testAgeVerifier() {
        let verifier = AgeVerifier()
        let oldDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
        let youngDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        XCTAssertTrue(verifier.isAdult(dob: formatter.string(from: oldDate)))
        XCTAssertFalse(verifier.isAdult(dob: formatter.string(from: youngDate)))
    }

    func testSceneDramatizerGeneratesClip() {
        let dramatizer = SceneDramatizer()
        let clip = dramatizer.generateSceneVideo(sceneText: "Hello world")
        XCTAssertEqual(clip.voiceFile, "/local/voice/scene_1.mp3")
        XCTAssertEqual(clip.imageFrames.count, 2)
    }

    func testRendererReturnsCorrectAsset() {
        let renderer = Renderer()
        let rendered = renderer.render(scene: "A", style: .anime)
        XCTAssertEqual(rendered.style, .anime)
        XCTAssertTrue(rendered.assets.first?.contains("anime") ?? false)
    }

    func testUploaderPlanRestriction() {
        let uploader = Uploader()
        let scene = RenderedScene(style: .fantasy, assets: [])
        XCTAssertTrue(uploader.upload(scene: scene, to: "defaultPlatform", userPlan: "basic"))
        XCTAssertFalse(uploader.upload(scene: scene, to: "YouTube", userPlan: "basic"))
    }
}
