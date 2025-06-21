import Foundation

/// Result of importing a text file into chapters with metadata.
public struct ImportedBook {
    public let title: String
    public let author: String?
    public let chapters: [Chapter]

    public init(title: String, author: String?, chapters: [Chapter]) {
        self.title = title
        self.author = author
        self.chapters = chapters
    }
}

/// Parses raw text into `Chapter` objects by blank lines.
public struct ChapterParser {
    public static func parse(_ text: String) -> [Chapter] {
        let normalized = text.replacingOccurrences(of: "\r\n", with: "\n")
        let blocks = normalized.components(separatedBy: "\n\n")
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        var chapters: [Chapter] = []
        var idx = 1
        for b in blocks {
            let lines = b.split(separator: "\n")
            guard let first = lines.first else { continue }
            var title = String(first).trimmingCharacters(in: .whitespaces)
            var start = 1
            if !title.lowercased().hasPrefix("chapter") {
                title = "Chapter \(idx)"
                start = 0
            }
            let body = lines.dropFirst(start).joined(separator: " ")
            if body.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { continue }
            chapters.append(Chapter(title: title, text: body))
            idx += 1
        }
        return chapters
    }
}

/// Imports TXT, PDF, and EPUB files from disk.
public final class BookImporter {
    public init() {}

    public func `import`(fileURL: URL) throws -> ImportedBook {
        let ext = fileURL.pathExtension.lowercased()
        let raw = try String(contentsOf: fileURL)
        let meta = Self.extractMetadata(from: raw, fileName: fileURL.lastPathComponent)
        let body = meta.body
        let chapters: [Chapter]
        switch ext {
        case "txt":
            chapters = ChapterParser.parse(body)
        case "pdf", "epub":
            chapters = [Chapter(title: "Chapter 1", text: body.replacingOccurrences(of: "\n", with: " "))]
        default:
            throw NSError(domain: "BookImporter", code: 1)
        }
        return ImportedBook(title: meta.title, author: meta.author, chapters: chapters)
    }

    private static func extractMetadata(from text: String, fileName: String) -> (title: String, author: String?, body: String) {
        let lines = text.replacingOccurrences(of: "\r\n", with: "\n").split(separator: "\n")
        var title = fileName.replacingOccurrences(of: "." + fileName.split(separator: ".").last!, with: "")
        var author: String?
        var index = 0
        if index < lines.count, lines[index].lowercased().hasPrefix("title:") {
            title = lines[index].dropFirst(6).trimmingCharacters(in: .whitespaces)
            index += 1
        } else if index < lines.count, lines[index].hasPrefix("#") {
            title = lines[index].trimmingCharacters(in: CharacterSet(charactersIn: "# "))
            index += 1
        }
        if index < lines.count, lines[index].lowercased().hasPrefix("author:") {
            author = lines[index].dropFirst(7).trimmingCharacters(in: .whitespaces)
            index += 1
        }
        let body = lines.dropFirst(index).joined(separator: "\n")
        return (title, author, body)
    }
}

