import Foundation

/// Metadata describing a rendered video for platform exports.
public struct VideoMetadata: Codable {
    public var title: String
    public var description: String
    public var tags: [String]
    public var duration: Double

    public init(title: String, description: String, tags: [String] = [], duration: Double) {
        self.title = title
        self.description = description
        self.tags = tags
        self.duration = duration
    }
}
