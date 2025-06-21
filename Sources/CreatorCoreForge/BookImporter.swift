import Foundation
#if canImport(PDFKit)
import PDFKit
#endif

/// Supported import errors.
public enum BookImportError: Error {
    case unsupportedFormat
    case readFailure
    case parsingFailure
    case noChaptersFound
}

/// Main Book Importer for EPUB, PDF, TXT
public class BookImporter {
    
    /// Import a book file and extract normalized chapters.
    /// - Parameter fileURL: URL to the file (local or temp)
    /// - Returns: An array of Chapter objects.
    public static func importBook(from fileURL: URL) async throws -> [Chapter] {
        let ext = fileURL.pathExtension.lowercased()
        switch ext {
        case "epub":
            return try await importEpub(from: fileURL)
        case "pdf":
            return try await importPdf(from: fileURL)
        case "txt":
            return try await importTxt(from: fileURL)
        default:
            throw BookImportError.unsupportedFormat
        }
    }
    
    private static func importEpub(from url: URL) async throws -> [Chapter] {
        // Placeholder — Replace with real EPUB parser integration
        // Simulate async fetch and split
        // For production: Use FolioReaderKit or similar Swift EPUB library
        throw BookImportError.unsupportedFormat // Remove after real implementation
    }
    
    #if canImport(PDFKit)
    private static func importPdf(from url: URL) async throws -> [Chapter] {
        guard let pdf = PDFDocument(url: url) else {
            throw BookImportError.readFailure
        }
        var chapters: [Chapter] = []
        let fullText = (0..<pdf.pageCount)
            .compactMap { pdf.page(at: $0)?.string }
            .joined(separator: "\n")
        let boundaries = detectChapterBoundaries(text: fullText)
        for (idx, boundary) in boundaries.enumerated() {
            chapters.append(
                Chapter(
                    title: boundary.title,
                    text: boundary.text,
                    order: idx,
                    metadata: nil
                )
            )
        }
        if chapters.isEmpty {
            throw BookImportError.noChaptersFound
        }
        return chapters
    }
    #else
    private static func importPdf(from url: URL) async throws -> [Chapter] {
        throw BookImportError.unsupportedFormat
    }
    #endif
    
    private static func importTxt(from url: URL) async throws -> [Chapter] {
        guard let rawText = try? String(contentsOf: url, encoding: .utf8) else {
            throw BookImportError.readFailure
        }
        let boundaries = detectChapterBoundaries(text: rawText)
        let chapters = boundaries.enumerated().map { idx, boundary in
            Chapter(
                title: boundary.title,
                text: boundary.text,
                order: idx,
                metadata: nil
            )
        }
        if chapters.isEmpty {
            throw BookImportError.noChaptersFound
        }
        return chapters
    }
    
    /// Heuristic rule-based chapter splitter.
    private static func detectChapterBoundaries(text: String) -> [(title: String, text: String)] {
        let regex = try! NSRegularExpression(pattern: #"(?m)^((CHAPTER|Chapter|Section|BOOK)[^\n]{0,40})$"#)
        let nsText = text as NSString
        let matches = regex.matches(in: text, range: NSRange(location: 0, length: nsText.length))
        guard matches.count > 1 else {
            return [(title: "Chapter 1", text: text)]
        }
        var boundaries: [(title: String, range: NSRange)] = []
        for (idx, match) in matches.enumerated() {
            let title = nsText.substring(with: match.range)
            let start = match.range.location
            let end = (idx < matches.count - 1) ? matches[idx + 1].range.location : nsText.length
            boundaries.append((title: title, range: NSRange(location: start, length: end - start)))
        }
        return boundaries.map {
            (title: $0.title, text: nsText.substring(with: $0.range).trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
}
