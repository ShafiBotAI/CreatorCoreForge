import Foundation

/// Provides convenience helpers for skipping common front-matter sections when importing books.
public struct AdvancedSkipImport {
    public static let defaultSkipKeywords: [String] = [
        "Prologue",
        "Preface",
        "Acknowledgment",
        "Acknowledgement",
        "Acknowledgments",
        "Dedication",
        "Copyright"
    ]

    /// Import a book while automatically skipping common front-matter sections.
    /// - Parameter fileURL: The file URL of the book.
    /// - Returns: Chapters with front-matter removed.
    public static func importSkippingExtras(from fileURL: URL) async throws -> [Chapter] {
        try await BookImporter.importBookSkipping(from: fileURL, skipKeywords: defaultSkipKeywords)
    }
}
