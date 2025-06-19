import Foundation

/// Import a plain text, ePub, or PDF file and split it into chapters.
/// This is a naive implementation that looks for the word "Chapter" or
/// numbers to detect breaks. For PDF/ePub you must supply already-extracted
/// text since no external libraries are available in this demo.
struct ChapterImporter {
    /// Split raw book text into chapters. If no chapters are detected, the
    /// entire text is returned as a single chapter.
    static func detectChapters(from text: String) -> [String] {
        let pattern = "(?i)chapter\\s+\\d+"
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return [text]
        }
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let matches = regex.matches(in: text, range: range)
        guard !matches.isEmpty else { return [text] }

        var chapters: [String] = []
        var lastIndex = text.startIndex
        for match in matches {
            let matchRange = Range(match.range, in: text)!
            if matchRange.lowerBound > lastIndex {
                let chunk = String(text[lastIndex..<matchRange.lowerBound])
                if !chunk.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    chapters.append(chunk)
                }
            }
            lastIndex = matchRange.lowerBound
        }
        let tail = String(text[lastIndex...])
        if !tail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            chapters.append(tail)
        }
        return chapters
    }
}
