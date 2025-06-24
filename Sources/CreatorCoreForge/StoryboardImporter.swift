import Foundation

/// Parses storyboard files into simple scene identifiers.
public final class StoryboardImporter {
    public init() {}

    /// Import a storyboard text and return scene identifiers.
    public func importStoryboard(_ text: String) -> [String] {
        text.split(separator: "\n").map { String($0) }.filter { !$0.isEmpty }
    }
}
