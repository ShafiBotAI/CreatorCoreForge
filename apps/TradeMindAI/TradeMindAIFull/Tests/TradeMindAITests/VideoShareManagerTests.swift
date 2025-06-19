import XCTest
#if canImport(UIKit)
import UIKit
#endif
@testable import TradeMindAI

final class VideoShareManagerTests: XCTestCase {
    func testActivityControllerType() {
        let url = URL(fileURLWithPath: "/tmp/video.mp4")
        let controller = VideoShareManager.activityController(for: url)
#if canImport(UIKit)
        XCTAssertTrue(controller is UIActivityViewController)
#else
        XCTAssertTrue((controller as? URL) == url)
#endif
    }
}
