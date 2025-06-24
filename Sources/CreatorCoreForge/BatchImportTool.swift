import Foundation

/// Imports multiple book files using `BookImporter`.
public struct BatchImportTool {
    public init() {}

    /// Import an array of book URLs.
    /// - Parameter urls: file URLs to import.
    /// - Returns: A dictionary mapping each URL to its chapters.
    public func importBooks(at urls: [URL]) async throws -> [URL: [Chapter]] {
        var result: [URL: [Chapter]] = [:]
        for url in urls {
            let chapters = try await BookImporter.importBook(from: url)
            result[url] = chapters
        }
        return result
    }
}
