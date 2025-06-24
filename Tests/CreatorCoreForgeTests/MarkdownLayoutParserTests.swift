import XCTest
@testable import CreatorCoreForge

final class MarkdownLayoutParserTests: XCTestCase {
    func testParsesBasicElements() {
        let parser = MarkdownLayoutParser()
        let md = "# Title\n- Item\nParagraph"
        let elements = parser.parse(md)
        XCTAssertEqual(elements, [.heading(text: "Title", level: 1), .bullet("Item"), .paragraph("Paragraph")])
    }

    func testParsesLayoutInstruction() {
        let parser = MarkdownLayoutParser()
        let md = "2-column login form"
        let elements = parser.parse(md)
        XCTAssertEqual(elements, [.layout(columns: 2, description: "login form")])
    }
}
