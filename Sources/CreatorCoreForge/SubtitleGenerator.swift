import Foundation

/// Represents a generated subtitle at a point in the timeline.
public struct Subtitle: Equatable {
    public let time: Int
    public let text: String
    public init(time: Int, text: String) {
        self.time = time
        self.text = text
    }
}

/// Generates simple subtitles by splitting lines of a script.
public func generateSubtitles(from script: String) -> [Subtitle] {
    script.split(whereSeparator: { $0.isNewline }).enumerated().map { index, line in
        Subtitle(time: index, text: String(line))
    }
}

/// Generate paired subtitles in two languages for overlay display.
public func generateDualLanguageSubtitles(base: String, translated: String) -> [(Subtitle, Subtitle)] {
    let first = generateSubtitles(from: base)
    let second = generateSubtitles(from: translated)
    let count = max(first.count, second.count)
    var result: [(Subtitle, Subtitle)] = []
    for i in 0..<count {
        let a = i < first.count ? first[i] : Subtitle(time: i, text: "")
        let b = i < second.count ? second[i] : Subtitle(time: i, text: "")
        result.append((a, b))
    }
    return result
}
