import Foundation

/// Utility helpers for audio export operations.
public struct ExportTools {
    public init() {}
    public func filename(for title: String) -> String {
        title.replacingOccurrences(of: " ", with: "_") + ".mp3"
    }
}
