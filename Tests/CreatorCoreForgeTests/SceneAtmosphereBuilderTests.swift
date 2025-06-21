import XCTest
@testable import CreatorCoreForge

final class SceneAtmosphereBuilderTests: XCTestCase {
    func testMoodRawValues() {
        XCTAssertEqual(SceneAtmosphereBuilder.Mood.tense.rawValue, "tense")
        XCTAssertEqual(SceneAtmosphereBuilder.Mood.sciFi.rawValue, "sciFi")
    }

    func testGenerateReturnsNilForMissingFile() {
        #if canImport(AVFoundation)
        let builder = SceneAtmosphereBuilder.shared
        let file = builder.generateAtmosphere(for: .tense, duration: 10)
        XCTAssertNil(file)
        #else
        XCTAssertNotNil(SceneAtmosphereBuilder.shared.generateAtmosphere(for: .tense, duration: 10))
        #endif
    }
}
