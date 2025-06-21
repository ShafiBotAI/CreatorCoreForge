import XCTest
@testable import VocalVision

final class MoodMixExporterTests: XCTestCase {
    func testExportMoodMixFiltersScenes() throws {
        let manager = VideoExportManager()
        let text = "Excited! Amazing! Another! Normal. Boring text. Calm vibes. More calm. End."
        let url = URL(fileURLWithPath: "/tmp/moodmix.txt")
        let exp = expectation(description: "export")
        manager.exportMoodMix(bookText: text, to: url, progress: { _ in }) { output in
            XCTAssertNotNil(output)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
        let contents = try String(contentsOf: url)
        let lines = contents.split(separator: "\n")
        XCTAssertEqual(lines.count, 1)
    }
}
