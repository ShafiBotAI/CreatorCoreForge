import Foundation

/// Simple HTML scraper for extracting leads from web pages.
public struct ChromeLeadScraper {
    public init() {}

    /// Extract email addresses from raw HTML text.
    public func scrapeEmails(from html: String) -> [String] {
        let pattern = "[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}"
        let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        let range = NSRange(html.startIndex..<html.endIndex, in: html)
        let matches = regex?.matches(in: html, options: [], range: range) ?? []
        return matches.compactMap { match in
            Range(match.range, in: html).map { String(html[$0]) }
        }
    }
}
