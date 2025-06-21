import Foundation

/// Flags text containing simple NSFW keywords.
public struct NSFWService {
    private static let words = ["sex", "nude", "xxx"]

    public init() {}

    public func flag(text: String) -> Bool {
        let pattern = "\\b(" + Self.words.joined(separator: "|") + ")\\b"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return false
        }
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        return regex.firstMatch(in: text, range: range) != nil
    }
}

