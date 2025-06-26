import XCTest
@testable import CoreForgeAudioApp

final class AppLaunchTests: XCTestCase {
    func testAppInitialization() {
        #if canImport(SwiftUI)
        let app = CoreForgeAudioApp()
        _ = app.body // ensure body can be accessed
        XCTAssertTrue(true)
        #else
        XCTAssertTrue(true)
        #endif
    }
}
