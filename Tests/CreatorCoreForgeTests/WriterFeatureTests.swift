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

    func testTimelineSynchronizer() {
        let syncer = TimelineSynchronizer()
        let result = syncer.synchronize(characters: ["A": [0]],
                                        locations: ["X": [0]],
                                        events: ["Start": [0]])
        XCTAssertEqual(result[0]?.count, 3)
    }

    func testFlashbackEngine() {
        var timeline: [SceneNode] = [
            SceneNode(text: "One", tone: .neutral, characters: [], timestamp: 0),
            SceneNode(text: "Two", tone: .neutral, characters: [], timestamp: 1)
        ]
        var engine = FlashbackEngine()
        engine.insertFlashback(scene: SceneNode(text: "Past", tone: .neutral, characters: [], timestamp: 0),
                               at: 1,
                               timeline: &timeline)
        XCTAssertEqual(timeline.count, 3)
        XCTAssertTrue(timeline[1].text.hasPrefix("[Flashback]"))
        XCTAssertEqual(timeline[2].timestamp, 2)
    }

    func testForeshadowingPlanner() {
        let planner = ForeshadowingPlanner()
        let hints = planner.generateSeeds(from: ["The hero will fall into darkness"])
        XCTAssertTrue(hints.first?.contains("The hero will") ?? false)
    }

    func testRelationshipHeatmap() {
        let map = RelationshipHeatmap()
        map.record(.romantic, between: "A", and: "B")
        map.record(.romantic, between: "A", and: "B")
        XCTAssertEqual(map.strength(.romantic, pair: ("A", "B")), 2)
    }

    func testLoreReferenceEnforcer() {
        let enforcer = LoreReferenceEnforcer()
        let missing = enforcer.missingReferences(in: "The prophecy speaks", required: ["prophecy", "legend"])
        XCTAssertEqual(missing, ["legend"])
    }

    func testPacingAdvisor() {
        let advisor = PacingAdvisor()
        let rec = advisor.recommend(wordCount: 300, genre: "thriller")
        XCTAssertTrue(rec.contains("shortening"))
    }

    func testSymbolismAnalyzer() {
        let analyzer = SymbolismAnalyzer()
        let counts = analyzer.analyze(text: "The red sun sets", symbols: ["sun", "moon"])
        XCTAssertEqual(counts["sun"], 1)
    }

    func testVisualSceneComposer() {
        let composer = VisualSceneComposer()
        let scene = composer.compose(from: "A dark forest under the moon")
        XCTAssertTrue(scene.referenceArt.contains("AI Art"))
    }

    func testIntensityScorer() {
        let scorer = IntensityScorer()
        let value = scorer.score(sceneText: "Run! Run!!!")
        XCTAssertGreaterThan(value, 0)
    }

    func testMultiverseTimelineBuilder() {
        let builder = MultiverseTimelineBuilder()
        let map = builder.build(base: ["A"], variants: [["B"]])
        XCTAssertEqual(map["variant1"]?.first, "B")
    }
}
