import Foundation

/// Provides simple book scanning and analysis utilities.
public final class BookScanAnalyzer {
    public init() {}

    /// Scan a book file using `BookImporter` and return the chapter count.
    public func scanBook(at url: URL) async throws -> Int {
        let chapters = try await BookImporter.importBook(from: url)
        return chapters.count
    }

    /// Compute word frequency across all chapters.
    public func analyze(chapters: [Chapter]) -> [String: Int] {
        var counts: [String: Int] = [:]
        for chapter in chapters {
            let words = chapter.text.lowercased().split { !$0.isLetter }
            for word in words {
                counts[String(word), default: 0] += 1
            }
        }
        return counts
    }
}
