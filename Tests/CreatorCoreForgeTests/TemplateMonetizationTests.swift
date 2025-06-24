import XCTest
@testable import CreatorCoreForge

final class TemplateMonetizationTests: XCTestCase {
    func testMonetize() {
        let monetizer = TemplateMonetization()
        XCTAssertEqual(monetizer.monetize(template: "intro", price: 1.99), "intro-for-1.99")
    }
}
