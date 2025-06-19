import Foundation

final class RecapEngine {
    func subtitleRecap(from subtitles: [String]) -> String {
        subtitles.joined(separator: " ")
    }

    func subtitleRecap(from subtitles: [String], limit: Int) -> String {
        let slice = subtitles.prefix(limit)
        return slice.joined(separator: " ")
    }

    func subtitleRecap(from subtitles: [SubtitleLine]) -> String {
        let text = subtitles.map { $0.text }
        return subtitleRecap(from: text)
    }

    func subtitleRecap(fromFile url: URL) throws -> String {
        let data = try String(contentsOf: url)
        let lines = data.components(separatedBy: "\n")
        return subtitleRecap(from: lines)
    }

    func subtitleToRecap(_ subtitles: [SubtitleLine], sentences: Int = 2) -> String {
        let joined = subtitleRecap(from: subtitles)
        let parts = joined.components(separatedBy: ".")
        let slice = parts.prefix(sentences)
        return slice.joined(separator: ".") + (slice.isEmpty ? "" : ".")
    }

    func subtitleToRecap(fromFile url: URL, sentences: Int = 2) throws -> String {
        let lines = try subtitleLines(fromFile: url)
        return subtitleToRecap(lines, sentences: sentences)
    }

    func quickRecap(from subtitles: [SubtitleLine]) -> String {
        subtitleToRecap(subtitles, sentences: 1)
    }

    func quickRecap(fromFile url: URL) throws -> String {
        try subtitleToRecap(fromFile: url, sentences: 1)
    }

    func contextualRecap(from subtitles: [SubtitleLine], context: String) -> String {
        let base = subtitleToRecap(subtitles, sentences: 2)
        return "\(context): \(base)"
    }

    private func subtitleLines(fromFile url: URL) throws -> [SubtitleLine] {
        let data = try String(contentsOf: url)
        let lines = data.components(separatedBy: "\n")
        return lines.enumerated().map { index, text in
            SubtitleLine(time: Double(index), text: text)
        }
    }
}

struct SubtitleLine {
    let time: Double
    let text: String
}
