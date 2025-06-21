import Foundation

/// Splits chapters into narration segments based on blank lines.
public struct SegmentService {
    public init() {}

    public func segment(_ chapters: [Chapter]) -> [Segment] {
        var segments: [Segment] = []
        for chap in chapters {
            let parts = chap.text.components(separatedBy: "\n\n")
            for part in parts {
                let trimmed = part.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmed.isEmpty { continue }
                segments.append(Segment(text: trimmed))
            }
        }
        return segments
    }
}

