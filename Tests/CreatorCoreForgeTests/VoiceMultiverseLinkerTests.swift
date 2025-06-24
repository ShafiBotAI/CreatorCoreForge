import XCTest
@testable import CreatorCoreForge

final class VoiceMultiverseLinkerTests: XCTestCase {
    func testLinkingAndQuery() {
        let linker = VoiceMultiverseLinker.shared
        linker.clearAll()
        linker.linkVoices(source: "voiceA", linked: "voiceB", project: "TestProj", reason: "alt timeline")
        linker.linkVoices(source: "voiceC", linked: "voiceA", project: "TestProj", reason: "cameo")
        let links = linker.getLinks(for: "voiceA")
        XCTAssertEqual(links.count, 2)
    }

    func testRemoveLink() {
        let linker = VoiceMultiverseLinker()
        linker.linkVoices(source: "v1", linked: "v2", project: "P", reason: "R")
        guard let firstID = linker.links.first?.id else {
            XCTFail("Link not created")
            return
        }
        linker.removeLink(firstID)
        XCTAssertTrue(linker.links.isEmpty)
    }

    func testSimpleLink() {
        let linker = VoiceMultiverseLinker()
        linker.clearAll()
        linker.linkVoices(primaryID: "a", secondaryID: "b")
        XCTAssertEqual(linker.getLinks(for: "a").count, 1)
    }
}
