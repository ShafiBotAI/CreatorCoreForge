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
        // On platforms without AVFoundation a stub URL is created so the
        // caller can still operate on an atmosphere file. Ensure a URL is
        // returned instead of `nil`.
        let url = SceneAtmosphereBuilder.shared.generateAtmosphere(for: .tense, duration: 10)
        XCTAssertNotNil(url)
        #endif
    }
}
