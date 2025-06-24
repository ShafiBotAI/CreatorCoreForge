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
        engine.record("swipe")
        XCTAssertEqual(engine.replay(), ["tap", "swipe"])
        XCTAssertEqual(engine.count, 2)
        XCTAssertEqual(engine.undo(), "swipe")
        XCTAssertEqual(engine.replay(), ["tap"])
        XCTAssertEqual(engine.count, 1)
        engine.clear()
        XCTAssertEqual(engine.replay(), [])
        XCTAssertEqual(engine.count, 0)
    }

    func testExportProduction() {
        let export = ExportProduction()
        let frames = export.export(frames: ["f"], watermark: "wm")
        XCTAssertEqual(frames.first, "f-wm(wm)")
    }
    func testFigmaImporter() {
        let build = CoreForgeBuildFeatures()
        let parts = build.importFigma(file: "A,B")
        XCTAssertEqual(parts, ["A", "B"])
    }

    func testUniversalBundler() {
        let build = CoreForgeBuildFeatures()
        let out = build.bundle(platforms: ["iOS"])
        XCTAssertEqual(out, ["iOS_bundle"])
    }

    func testDebugAssistant() {
        let build = CoreForgeBuildFeatures()
        let hints = build.debugHints(for: "Error")
        XCTAssertTrue(hints.first?.contains("Error") ?? false)
    }

    func testDNATreeUI() {
        let child = DNATreeNode(name: "Child")
        let root = DNATreeNode(name: "Root", children: [child])
        let features = CoreForgeDNAFeatures()
        XCTAssertEqual(features.visualize(root), ["Root", "Child"])
    }

    func testDNACrossAppSync() {
        let features = CoreForgeDNAFeatures()
        let data = features.export(profile: ["a": "b"])
        let profile = features.importProfile(data: data)
        XCTAssertEqual(profile["a"], "b")
    }

    func testDNAMultiverseMerge() {
        let features = CoreForgeDNAFeatures()
        let merged = features.merge(timelineA: ["A"], timelineB: ["B"])
        XCTAssertEqual(Set(merged), ["A", "B"])
    }

    func testMusicFeatures() {
        let music = CoreForgeMusicFeatures()
        XCTAssertEqual(music.produceVocals(track: "beat", voice: "vox"), "beat-vocals-vox")
        XCTAssertEqual(music.exportCommercial(track: "song", license: "cc"), "song-licensed(cc)")
        XCTAssertTrue(music.publishHook(name: "hook"))
    }

    func testLeadsFeatures() {
        let ledger = CreditLedger()
        ledger.add(10)
        XCTAssertTrue(ledger.bill(5))
        let exchange = GlobalExchange()
        XCTAssertTrue(exchange.trade(id: "L1", for: 5).contains("L1"))
        let scoring = ScoringEngine()
        XCTAssertEqual(scoring.score(leads: [1,3]), 2.0)
    }

    func testMindFeatures() {
        let journal = MoodJournal()
        journal.addEntry("I am sad")
        journal.addEntry("This is amazing!")
        let breakdown = journal.moodBreakdown()
        XCTAssertEqual(journal.count, 2)
        XCTAssertEqual(breakdown["somber"], 1)
        XCTAssertEqual(breakdown["excited"], 1)
        XCTAssertEqual(GuidedSessions().play(session: "med"), "Playing med")
        let vault = PrivateVault()
        vault.save(key: "k", value: "v")
        XCTAssertEqual(vault.fetch(key: "k"), "v")
    }

    func testBloomFeatures() {
        let tracker = CycleTracker()
        let next = tracker.predict(last: Date(timeIntervalSince1970: 0), cycleLength: 28)
        XCTAssertTrue(next > Date(timeIntervalSince1970: 0))
        XCTAssertEqual(WellnessReminder().remind("stretch"), "Reminder: stretch")
        XCTAssertEqual(WearableSync().sync(data: ["steps": 5, "cal": 5]), 10)
    }

    func testLearnFeatures() {
        let builder = CurriculumBuilder()
        let lesson = builder.makeLesson(from: "A. B.")
        XCTAssertEqual(lesson, ["A", "B"])
        XCTAssertEqual(AITutor().feedback(score: 90), "Great job")
        var sync = OfflineSync()
        sync.add("x")
        XCTAssertEqual(sync.count, 1)

        var quiz = QuizBuilder()
        quiz.add(prompt: "1+1?", answer: "2")
        XCTAssertEqual(quiz.grade(responses: ["2"]), 1)

        var market = CourseMarketplace()
        market.publish(course: "Swift")
        XCTAssertEqual(market.list(), ["Swift"])
    }

    func testQuestFeatures() {
        let gen = ChallengeGenerator()
        XCTAssertEqual(gen.generate(from: "go north"), ["go", "north"])
        XCTAssertEqual(LeaderboardEvents().rank(scores: [1,3,2]), [3,2,1])
        XCTAssertEqual(MarketplaceItems().trade(item: "sword", for: 5), "sword-for-5")
    }

    func testVoiceLabFeatures() {
        let rec = RecordingTools()
        XCTAssertEqual(rec.trim([1,2,3], to: 2), [1,2])
        XCTAssertTrue(TrainingPipeline().prepare(samples: [0.1]))
        XCTAssertEqual(ExportHooks().send(name: "voice"), "Sent voice")
    }

    func testMarketFeatures() {
        let engine = QuantumTradingEngine()
        XCTAssertEqual(engine.analyze(prices: [1.0, 3.0]), 2.0)
        let team = TeamTrading()
        team.addTrade("buy")
        XCTAssertEqual(team.trades.count, 1)
        XCTAssertTrue(BotMarketplace().publish(bot: "bot"))
    }

    func testWriterFeatures() {
        var tracker = SeriesMemoryTracker()
        tracker.record(book: "Book1", events: ["A"])
        XCTAssertEqual(tracker.allEvents(), ["A"])
        let handler = PromoCodeHandler()
        XCTAssertEqual(handler.apply(code: "FREE100", to: 10), 0)
        let tuner = WritingMoodTuner()
        XCTAssertEqual(tuner.tune(text: "Hello", mood: "Happy"), "Happy: Hello")
    }

    func testStudioFeatures() {
        let director = SmartCameraDirector()
        XCTAssertEqual(director.suggestAngles(for: "scene").count, 3)
        let alt = WhatIfCutsceneMode().alternateScenes(scene: "Scene1")
        XCTAssertEqual(alt.last, "What if Scene1?")
        let pipeline = AutoPublishPipeline()
        let url = URL(fileURLWithPath: "video.mp4")
        XCTAssertTrue(pipeline.publish(video: url).contains("video.mp4"))
    }
}
