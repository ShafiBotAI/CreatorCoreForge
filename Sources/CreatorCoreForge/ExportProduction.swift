import Foundation

/// Generates production exports with an optional watermark.
public final class ExportProduction {
    public init() {}

    public func export(frames: [String], watermark: String? = nil) -> [String] {
        if let mark = watermark {
            return frames.map { "\($0)-wm(\(mark))" }
        }
        return frames
    }
}
