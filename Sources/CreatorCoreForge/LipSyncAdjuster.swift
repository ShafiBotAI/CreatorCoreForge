import Foundation

/// Adjust lip sync timings after translation using average word length ratio.
public struct LipSyncAdjuster {
    public init() {}

    /// - Parameters:
    ///   - timings: original timings in seconds for each line
    ///   - source: source language
    ///   - target: target language
    ///   - sourceText: original text
    ///   - translated: translated text
    public func adjustTimings(_ timings: [Double],
                              sourceText: [String],
                              translated: [String]) -> [Double] {
        guard !sourceText.isEmpty, sourceText.count == timings.count else { return timings }
        var result: [Double] = []
        for (idx, time) in timings.enumerated() {
            let src = Double(sourceText[idx].count)
            let tgt = Double(translated[idx].count)
            let ratio = tgt / max(src, 1)
            result.append(time * ratio)
        }
        return result
    }
}
