import XCTest
@testable import CreatorCoreForge
#if canImport(UIKit)
import UIKit
#endif

final class VideoShareManagerTests: XCTestCase {
    func testActivityControllerType() {
        let url = URL(fileURLWithPath: "/tmp/video.mp4")
        let controller = VideoShareManager.activityController(for: url)
#if canImport(UIKit)
        XCTAssertTrue(controller is UIActivityViewController)
#else
        XCTAssertEqual(controller as? URL, url)
#endif
    }
}
