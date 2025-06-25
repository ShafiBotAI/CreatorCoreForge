import XCTest
@testable import CreatorCoreForge

final class BuildImprovementEngineTests: XCTestCase {
    func testScanProjectDetectsMissingImplementation() throws {
        let dir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        let file = dir.appendingPathComponent("Sample.swift")
        try "func demo() { fatalError(\"Not implemented\") }".write(to: file, atomically: true, encoding: .utf8)
        let engine = BuildImprovementEngine()
        let issues = engine.scanProject(at: dir.path)
        XCTAssertTrue(issues.contains { $0.contains("Missing implementation") })
    }

    func testFixMissingCodeReplacesFatalError() throws {
        let dir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        let file = dir.appendingPathComponent("Sample.swift")
        try "func demo() { fatalError(\"Not implemented\") }".write(to: file, atomically: true, encoding: .utf8)
        let engine = BuildImprovementEngine()
        XCTAssertEqual(engine.fixMissingCode(at: dir.path), 1)
        let updated = try String(contentsOf: file)
        XCTAssertTrue(updated.contains("// TODO: implement"))
    }

    func testRecommendEnhancementsSuggestsTwoFactor() {
        let engine = BuildImprovementEngine()
        let recs = engine.recommendEnhancements(for: ["login screen"])
        XCTAssertTrue(recs.contains { $0.contains("two-factor") })
    }

    func testValidateCompliancePassesWhenDocsExist() throws {
        let dir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        FileManager.default.createFile(atPath: dir.appendingPathComponent("PrivacyPolicy.md").path, contents: Data())
        FileManager.default.createFile(atPath: dir.appendingPathComponent("TermsOfService.md").path, contents: Data())
        let engine = BuildImprovementEngine()
        XCTAssertTrue(engine.validateCompliance(at: dir.path))
    }

    func testOptimizationScoreAndUsageTracker() throws {
        let dir = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        let file = dir.appendingPathComponent("Sample.swift")
        try "// TODO".write(to: file, atomically: true, encoding: .utf8)
        let engine = BuildImprovementEngine()
        let score = engine.optimizationScore(for: dir.path)
        XCTAssertLessThan(score, 1)
        engine.recordAIUsage(feature: "test")
        engine.recordAIUsage(feature: "test")
        engine.recordAIUsage(feature: "test")
        engine.recordAIUsage(feature: "test")
        XCTAssertFalse(engine.usageOptimizationTips().isEmpty)
    }
}
