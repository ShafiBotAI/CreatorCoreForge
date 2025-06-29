import XCTest
import SwiftCheck
@testable import CreatorCoreForge

final class PropertyTests: XCTestCase {
    func testReversingTwice() {
        property("reversing twice yields original") <- forAll { (value: String) in
            return String(value.reversed().reversed()) == value
        }
    }
}
