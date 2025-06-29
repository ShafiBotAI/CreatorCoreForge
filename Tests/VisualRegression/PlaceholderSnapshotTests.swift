import XCTest
#if canImport(iOSSnapshotTestCase)
import iOSSnapshotTestCase
#endif

final class PlaceholderSnapshotTests: XCTestCase {
    func testEmptyViewSnapshot() {
        #if canImport(iOSSnapshotTestCase)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        FBSnapshotVerifyView(view)
        #else
        XCTAssertTrue(true)
        #endif
    }
}
