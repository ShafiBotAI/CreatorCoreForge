import Foundation

/// Basic metadata for audiobook exports.
public struct Metadata: Codable {
    public var title: String
    public var author: String
    public var narrator: String?

    public init(title: String, author: String, narrator: String? = nil) {
        self.title = title
        self.author = author
        self.narrator = narrator
    }
}
