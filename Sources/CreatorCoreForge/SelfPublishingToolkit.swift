import Foundation

/// Toolkit for exporting books to multiple self-publishing formats.
public struct SelfPublishingToolkit {
    public init() {}

    public func export(title: String, formats: [String]) -> [String] {
        formats.map { "\(title).\($0.lowercased())" }
    }
}
