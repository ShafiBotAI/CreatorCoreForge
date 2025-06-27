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
        case "docx":
            return try parseDocx(url: url)
        case "epub", "pdf":
            let importer = EbookImporter()
            let chapters = importer.importEbook(from: url.path)
            return chapters.joined(separator: "\n")
        default:
            throw ParserError.unsupportedType
        }
    }

    private func parseDocx(url: URL) throws -> String {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/unzip")
        process.arguments = ["-p", url.path, "word/document.xml"]
        let pipe = Pipe()
        process.standardOutput = pipe
        try process.run()
        process.waitUntilExit()
        guard process.terminationStatus == 0 else { throw ParserError.unreadable }
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let xml = String(data: data, encoding: .utf8) else { throw ParserError.unreadable }
        let stripped = xml.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression)
        let collapsed = stripped.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
        return collapsed.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
