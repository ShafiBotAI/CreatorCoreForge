import Foundation

/// Splits text into semantic blocks using simple sentence grouping.
public struct SemanticSegmenter {
    public init() {}

    /// Returns grouped segments separated by sentence endings or topic markers.
    public func segments(from text: String) -> [String] {
        let sentences = text.split(whereSeparator: { ".!?".contains($0) })
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        var groups: [String] = []
        var current = ""
        for sentence in sentences {
            current += sentence + ". "
            if sentence.hasSuffix(":") || current.count > 150 {
                groups.append(current.trimmingCharacters(in: .whitespaces))
                current = ""
            }
        }
        if !current.isEmpty { groups.append(current.trimmingCharacters(in: .whitespaces)) }
        return groups
    }
}
