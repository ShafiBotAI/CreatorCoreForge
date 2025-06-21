import Foundation

/// Generates short marketing blurbs and summaries from text.
public struct BlurbGenerator {
    public init() {}

    /// Returns a brief blurb truncated to `maxLength` characters.
    public func generateBlurb(from text: String, maxLength: Int = 150) -> String {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.count > maxLength else { return trimmed }
        let index = trimmed.index(trimmed.startIndex, offsetBy: maxLength)
        var snippet = String(trimmed[..<index])
        if let lastPeriod = snippet.lastIndex(of: ".") {
            snippet = String(snippet[..<snippet.index(after: lastPeriod)])
        }
        return snippet + "..."
    }

    /// Builds a short synopsis using the first few sentences.
    public func generateSynopsis(from text: String, sentenceLimit: Int = 3) -> String {
        let sentences = text.split(separator: ".").map { $0.trimmingCharacters(in: .whitespaces) }
        let selected = sentences.prefix(sentenceLimit).joined(separator: ". ")
        return selected.isEmpty ? "" : selected + "."
    }

    /// Produces simple back cover copy from the first and last sentences.
    public func generateBackCoverCopy(from text: String) -> String {
        let sentences = text.split(separator: ".").map { $0.trimmingCharacters(in: .whitespaces) }
        guard let first = sentences.first else { return "" }
        let last = sentences.dropFirst().last ?? first
        return first + "... " + last + "."
    }
}
