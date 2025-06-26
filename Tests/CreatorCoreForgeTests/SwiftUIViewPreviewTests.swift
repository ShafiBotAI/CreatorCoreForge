import XCTest

final class SwiftUIViewPreviewTests: XCTestCase {
    func testAllAudioViewsContainPreviews() throws {
        let testBundle = Bundle(for: type(of: self))
        let rootURL = URL(fileURLWithPath: testBundle.bundleURL.path)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let viewsURL = rootURL.appendingPathComponent("apps/CoreForgeAudio/views")
        let files = try FileManager.default.contentsOfDirectory(atPath: viewsURL.path)
        for file in files where file.hasSuffix(".swift") {
            let content = try String(contentsOf: viewsURL.appendingPathComponent(file))
            XCTAssertTrue(content.contains("Preview"), "\(file) missing preview")
        }
    }
}
