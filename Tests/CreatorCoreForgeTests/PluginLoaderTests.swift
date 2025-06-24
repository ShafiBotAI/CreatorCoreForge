import XCTest
@testable import CreatorCoreForge

final class PluginLoaderTests: XCTestCase {
    func testLoadAndValidate() throws {
        let manifest = PluginManifest(name: "Test", version: "1.0", inputs: [], outputs: [], permissions: [], premium: false)
        let data = try JSONEncoder().encode(manifest)
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("m.json")
        try data.write(to: url)
        let loader = PluginLoader()
        let loaded = loader.loadManifest(at: url)
        XCTAssertNotNil(loaded)
        XCTAssertTrue(loader.validate(manifest: loaded!))

        // directory loading
        let dir = FileManager.default.temporaryDirectory.appendingPathComponent("plugs")
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        try data.write(to: dir.appendingPathComponent("manifest.json"))
        XCTAssertEqual(loader.loadPlugins(in: dir).count, 1)
    }
}
