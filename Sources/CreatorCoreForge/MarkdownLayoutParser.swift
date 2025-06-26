import Foundation

/// Simplified representation of a parsed UI element.
public enum ASUIMElement: Equatable {
    case heading(text: String, level: Int)
    case paragraph(String)
    case bullet(String)
    /// Layout description such as "2-column login form".
    case layout(columns: Int, description: String)
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
            } else if let layout = MarkdownLayoutParser.parseLayout(from: trimmed) {
                elements.append(layout)
            } else if !trimmed.isEmpty {
                elements.append(.paragraph(trimmed))
            }
        }
        return elements
    }

    private static func parseLayout(from line: String) -> ASUIMElement? {
        let pattern = "^(\\d+)-column\\s+(.+)"
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            let range = NSRange(location: 0, length: line.utf16.count)
            if let match = regex.firstMatch(in: line, options: [], range: range),
               let colRange = Range(match.range(at: 1), in: line),
               let descRange = Range(match.range(at: 2), in: line),
               let cols = Int(line[colRange]) {
                return .layout(columns: cols, description: String(line[descRange]))
            }
        }
        // Default to a single column layout when no markers are found
        return .layout(columns: 1, description: "auto")
    }
}
