import Foundation

/// Simple engine converting natural input to a very basic schema and logic flow.
public struct PromptParserEngine {
    private let parser: PromptParser

    public init(parser: PromptParser = PromptParser()) {
        self.parser = parser
    }

    /// Parse text and return normalized text with flows separated by arrows and detected language code.
    public func parseSchema(from text: String) -> (normalized: String, flows: [[String]], language: String) {
=======
    /// Parse text and return normalized text with flows separated by arrows.
    public func parseSchema(from text: String) -> (normalized: String, flows: [[String]]) {

        let result = parser.parse(text)
        let flows = text
            .split(separator: "\n")
            .filter { $0.contains("->") }
            .map { $0.split(separator: "->").map { $0.trimmingCharacters(in: .whitespaces) } }


        let lower = text.lowercased()
        let language: String
        if lower.contains("hola") || lower.contains("gracias") {
            language = "es"
        } else if lower.contains("你好") || lower.contains("谢谢") {
            language = "zh"
        } else {
            language = "en"
        }

        return (result.text, flows, language)
=======
        return (result.text, flows)

    }
}
