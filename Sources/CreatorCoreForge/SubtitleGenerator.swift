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
