import Foundation

/// Converts subtitle files from AniList or IMDb into short recaps.
final class SubtitleToRecapTool {
    private let recapEngine = RecapEngine()

    func recap(fromAnilist subtitles: [String]) -> String {
        return recapEngine.subtitleToRecap(subtitles.map { SubtitleLine(time: 0, text: $0) })
    }

    func recap(fromIMDB url: URL) throws -> String {
        let data = try String(contentsOf: url)
        let lines = data.components(separatedBy: "\n")
        let subtitleLines = lines.enumerated().map { index, text in
            SubtitleLine(time: Double(index), text: text)
        }
        return recapEngine.subtitleToRecap(subtitleLines)
    }
}
