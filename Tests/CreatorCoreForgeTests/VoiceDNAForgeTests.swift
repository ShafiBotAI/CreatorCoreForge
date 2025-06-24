import XCTest
@testable import CreatorCoreForge

final class VoiceDNAForgeTests: XCTestCase {
    func testCreateAndRetrieveDNA() {
        let forge = VoiceDNAForge.shared
        forge.resetAllDNA()
        forge.createDNA(for: "hero", basePitch: 1.0, cadence: 0.9, toneProfile: "brave", emotionRange: ["joy": 0.7], styleTags: ["noble"])
        let dna = forge.getDNA(for: "hero")
        XCTAssertEqual(dna?.toneProfile, "brave")
    }

    func testLinkAndEmotionUpdate() {
        let forge = VoiceDNAForge.shared
        forge.resetAllDNA()
        forge.createDNA(for: "hero", basePitch: 1.0, cadence: 1.0, toneProfile: "brave", emotionRange: [:], styleTags: [])
        forge.linkCharacters(primaryID: "hero", linkedID: "villain")
        forge.updateEmotionProfile(for: "hero", emotion: "anger", intensity: 0.5)

        let dna = forge.getDNA(for: "hero")
        XCTAssertTrue(dna?.linkedCharacters.contains("villain") ?? false)
        XCTAssertEqual(dna?.emotionRange["anger"], 0.5)
    }

    func testGetVoiceProfile() {
        let forge = VoiceDNAForge.shared
        forge.resetAllDNA()
        forge.createDNA(for: "testChar", basePitch: 1.0, cadence: 1.0, toneProfile: "calm", emotionRange: [:], styleTags: [])
        let dna = forge.getVoiceProfile(for: "testChar")
        XCTAssertEqual(dna?.toneProfile, "calm")
    }
}
