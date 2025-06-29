import Foundation

/// Converts book chapters into a simple lore wiki structure for fans.
public struct FanModeConverter {
    public init() {}

    public func convert(chapters: [String]) -> [String: [String]] {
        var wiki: [String: [String]] = [:]
        for (index, chapter) in chapters.enumerated() {
            let lines = chapter.split(separator: ".").map { $0.trimmingCharacters(in: .whitespaces) }
            wiki["Chapter \(index + 1)"] = lines
        }
        return wiki
    }
}
