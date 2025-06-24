import XCTest
@testable import CreatorCoreForge

final class PluginLoaderTests: XCTestCase {
    func testLoadAndValidate() throws {
        let manifest = PluginManifest(name: "Test", version: "1.0", inputs: [], outputs: [], permissions: [])
        let data = try JSONEncoder().encode(manifest)
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("m.json")
        try data.write(to: url)
        let loader = PluginLoader()
        let loaded = loader.loadManifest(at: url)
        XCTAssertNotNil(loaded)
        XCTAssertTrue(loader.validate(manifest: loaded!))
    }
}
