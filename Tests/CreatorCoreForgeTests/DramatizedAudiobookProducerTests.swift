import XCTest
@testable import CreatorCoreForge

final class DramatizedAudiobookProducerTests: XCTestCase {
    func testProduceAddsAmbienceHeader() {
        let chapters = [[POVSegment(character: "Narrator", text: "Test line")]]
        let producer = DramatizedAudiobookProducer()
        let output = producer.produce(chapters: chapters, ambience: ["rain"])
        XCTAssertTrue(output[0].contains("SFX: rain"))
    }
}
