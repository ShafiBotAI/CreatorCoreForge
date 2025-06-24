import Foundation

/// Location of a detected chapter within raw text.
public struct ChapterBoundary {
    public let title: String
    public let range: Range<String.Index>

    public init(title: String, range: Range<String.Index>) {
        self.title = title
        self.range = range
    }
}

/// Detects chapter boundaries using simple heuristics.
public struct ChapterDetector {
    public static func detect(in text: String) -> [ChapterBoundary] {
        let pattern = "(?i)chapter\\s+\\d+"
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return [ChapterBoundary(title: "Chapter 1", range: text.startIndex..<text.endIndex)]
        }
        let nsrange = NSRange(text.startIndex..<text.endIndex, in: text)
        let matches = regex.matches(in: text, range: nsrange)
        guard !matches.isEmpty else {
            return [ChapterBoundary(title: "Chapter 1", range: text.startIndex..<text.endIndex)]
        }
        var boundaries: [ChapterBoundary] = []
        var last = text.startIndex
        for (idx, match) in matches.enumerated() {
            let r = Range(match.range, in: text)!
            if last < r.lowerBound {
                let range = last..<r.lowerBound
                let title = "Chapter \(idx)"
                boundaries.append(ChapterBoundary(title: title, range: range))
            }
            last = r.lowerBound
        }
        let finalRange = last..<text.endIndex
        boundaries.append(ChapterBoundary(title: "Chapter \(boundaries.count + 1)", range: finalRange))
        return boundaries
    }
}

