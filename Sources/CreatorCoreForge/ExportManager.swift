import Foundation

/// Simplified export handler for CoreForge Build projects.
public struct ExportManager {
    public init() {}

    /// Export an app bundle for the given platform into the output directory.
    public func export(platform: String, output: String) -> String {
        let path = URL(fileURLWithPath: output).appendingPathComponent("\(platform).bundle").path
        FileManager.default.createFile(atPath: path, contents: Data(), attributes: nil)
        return path
    }

    /// Validate exported file exists.
    public func validate(path: String) -> Bool {
        FileManager.default.fileExists(atPath: path)
    }
}
