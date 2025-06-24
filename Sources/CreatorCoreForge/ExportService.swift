import Foundation

/// Writes text to simple ePub/Docx-like files.
public final class ExportService {
    public init() {}

    public func export(text: String, to url: URL) throws {
        try text.write(to: url, atomically: true, encoding: .utf8)
    }
}
