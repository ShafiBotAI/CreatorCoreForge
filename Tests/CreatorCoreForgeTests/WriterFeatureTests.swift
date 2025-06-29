import XCTest
@testable import CreatorCoreForge

final class WriterFeatureTests: XCTestCase {
    func testDynamicCastBuilder() {
        let builder = DynamicCastBuilder()
        let povs = builder.assignPOVs(characters: ["A", "B"], sceneCount: 3)
        XCTAssertEqual(povs[0], "A")
        XCTAssertEqual(povs[1], "B")
        XCTAssertEqual(povs[2], "A")
    }

    func testCharacterGrowthTracker() {
        let tracker = CharacterGrowthTracker()
        tracker.record(character: "Hero", chapter: 1, description: "Starts journey")
        tracker.record(character: "Hero", chapter: 2, description: "Learns skill")
        XCTAssertEqual(tracker.timeline(for: "Hero").count, 2)
    }

    func testToneAdapter() {
        let adapter = ToneAdapter()
        let result = adapter.rewrite("It rains", style: .noir)
        XCTAssertTrue(result.hasPrefix("[Noir]"))
    }

    func testMythologyGenerator() {
        let gen = MythologyGenerator()
        XCTAssertTrue(gen.generateGod(name: "Zephar").contains("Zephar"))
    }

    func testMotifTracker() {
        let tracker = MotifTracker()
        tracker.register("sword")
        tracker.register("sword")
        XCTAssertEqual(tracker.occurrences(of: "sword"), 2)
    }

    func testCanonEnforcer() {
        let enforcer = CanonEnforcer()
        XCTAssertTrue(enforcer.validate(text: "The prophecy speaks", canonFacts: ["prophecy"]))
    }

    func testVillainAnalyzer() {
        let analyzer = VillainAnalyzer()
        let analysis = analyzer.analyze("A tragic villain with a fatal flaw")
        XCTAssertGreaterThan(analysis.sympathyScore, 0)
        XCTAssertGreaterThan(analysis.flawScore, 0)
    }

    func testOneClickStoryboarder() {
        let boarder = OneClickStoryboarder()
        let result = boarder.generate(from: ["Intro", "Climax"])
        XCTAssertEqual(result.first, "Scene 1: Intro")
    }

    func testLoreHierarchyVisualizer() {
        let viz = LoreHierarchyVisualizer()
        let tree = viz.buildHierarchy(race: "Elves", kingdom: "Aleron", myth: "Creation", artifact: "Sword")
        XCTAssertEqual(tree.children.first?.children.first?.name, "Creation")
    }

    func testScreenplayConverter() {
        let converter = ScreenplayConverter()
        let result = converter.convert(chapters: ["First", "Second"])
        XCTAssertTrue(result.contains("Scene 1"))
        XCTAssertTrue(result.contains("Scene 2"))
    }
}
