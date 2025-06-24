import Foundation

/// Splits book text into logical chapter segments using headings.
public struct ChapterSegmenter {
    public init() {}

    public func segments(from text: String) -> [String] {
        let pattern = "(?i)chapter\\s+\\d+"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [text] }
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let matches = regex.matches(in: text, range: range)
        guard !matches.isEmpty else { return [text] }

        var chapters: [String] = []
        var last = text.startIndex
        for match in matches {
            let mRange = Range(match.range, in: text)!
            if mRange.lowerBound > last {
                let chunk = String(text[last..<mRange.lowerBound])
                if !chunk.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    chapters.append(chunk)
                }
            }
            last = mRange.upperBound
        }
        let tail = String(text[last...])
        if !tail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            chapters.append(tail)
        }
        return chapters
    }
}
