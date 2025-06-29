import XCTest
#if canImport(iOSSnapshotTestCase)
import iOSSnapshotTestCase

final class VisualRegressionTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testEmptyViewSnapshot() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .red
        FBSnapshotVerifyView(view)
    }
}
#endif
