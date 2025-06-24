import Foundation

/// Simplified representation of a parsed UI element.
public enum ASUIMElement: Equatable {
    case heading(text: String, level: Int)
    case paragraph(String)
    case bullet(String)
}

/// Converts Markdown-style text into an array of `ASUIMElement` items.
public struct MarkdownLayoutParser {
    public init() {}

    public func parse(_ markdown: String) -> [ASUIMElement] {
        var elements: [ASUIMElement] = []
        for line in markdown.split(separator: "\n") {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if trimmed.hasPrefix("#") {
                let level = trimmed.prefix { $0 == "#" }.count
                let text = trimmed.drop { $0 == "#" || $0 == " " }
                elements.append(.heading(text: String(text), level: level))
            } else if trimmed.hasPrefix("-") {
                let text = trimmed.dropFirst().trimmingCharacters(in: .whitespaces)
                elements.append(.bullet(String(text)))
            } else if !trimmed.isEmpty {
                elements.append(.paragraph(trimmed))
            }
        }
        return elements
    }
}
