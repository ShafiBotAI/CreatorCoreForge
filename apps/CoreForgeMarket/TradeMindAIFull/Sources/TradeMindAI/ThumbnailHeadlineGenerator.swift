import Foundation

/// Produces a basic headline and placeholder thumbnail path for a trade idea.
public struct ThumbnailHeadlineGenerator {
    public init() {}

    public func generate(for idea: String) -> (thumbnail: String, headline: String) {
        let headline = idea.capitalized + " Opportunity"
        let file = idea.replacingOccurrences(of: " ", with: "_").lowercased() + ".png"
        return (thumbnail: file, headline: headline)
    }
}
