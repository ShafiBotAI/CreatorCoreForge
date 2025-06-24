import Foundation

/// Suggests playback speed multipliers for long-form narration.
public struct LongFormPacingEngine {
    public init() {}

    public func suggestedPace(for chapters: [Chapter]) -> Double {
        let totalWords = chapters.reduce(0) { $0 + $1.text.split { $0.isWhitespace }.count }
        switch totalWords {
        case 0..<10000:
            return 1.0
        case 10000..<50000:
            return 1.2
        default:
            return 1.3
        }
    }
}
