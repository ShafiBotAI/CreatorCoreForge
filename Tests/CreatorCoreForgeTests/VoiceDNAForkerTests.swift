import XCTest
@testable import CreatorCoreForge

final class VoiceDNAForkerTests: XCTestCase {
    func testCreateAndFetchVariants() {
        let forker = VoiceDNAForker.shared
        forker.clearAllVariants()
        forker.createVariant(from: "base", name: "Deep", pitch: -0.2, speed: 0.0, tone: "calm")
        forker.createVariant(from: "base", name: "Fast", pitch: 0.0, speed: 0.1, tone: "excited")
        let variants = forker.getVariants(for: "base")
        XCTAssertEqual(variants.count, 2)
    }

    func testDeleteVariant() {
        let forker = VoiceDNAForker.shared
        forker.clearAllVariants()
        forker.createVariant(from: "base", name: "Old", pitch: -0.1, speed: -0.1, tone: "aged")
        guard let id = forker.getVariants(for: "base").first?.id else {
            XCTFail("Variant not created")
            return
        }
        forker.deleteVariant(id)
        XCTAssertEqual(forker.getVariants(for: "base").count, 0)
    }
}
