import Foundation

/// Parses supported document types into plain text.
public final class DocumentParser {
    public enum ParserError: Error {
        case unsupportedType
        case unreadable
    }

    public init() {}

    /// Parse the document at the given URL and return plain text.
    public func parse(url: URL) throws -> String {
        let ext = url.pathExtension.lowercased()
        switch ext {
        case "txt", "md", "markdown", "tex", "latex":
            return try String(contentsOf: url)
        case "epub", "pdf", "docx":
            let importer = EbookImporter()
            let chapters = importer.importEbook(from: url.path)
            return chapters.joined(separator: "\n")
        default:
            throw ParserError.unsupportedType
        }
    }
}
