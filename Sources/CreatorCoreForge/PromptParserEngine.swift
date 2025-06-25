import Foundation

/// Simple engine converting natural input to a very basic schema and logic flow.
public struct PromptParserEngine {
    private let parser: PromptParser

    public init(parser: PromptParser = PromptParser()) {
        self.parser = parser
    }

    /// Parse text and return normalized text with flows separated by arrows.
    public func parseSchema(from text: String) -> (normalized: String, flows: [[String]]) {
        let result = parser.parse(text)
        let flows = text
            .split(separator: "\n")
            .filter { $0.contains("->") }
            .map { $0.split(separator: "->").map { $0.trimmingCharacters(in: .whitespaces) } }
        return (result.text, flows)
    }
}
