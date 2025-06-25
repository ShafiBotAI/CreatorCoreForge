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


    /// Return an array of blocker messages if the export cannot proceed.
    public func detectExportBlockers(screens: Int, logicValid: Bool) -> [String] {
        var issues: [String] = []
        if screens == 0 { issues.append("no screens defined") }
        if !logicValid { issues.append("logic validation failed") }
=======
    /// Detect common export blockers like missing login screen or icons.
    public func detectBlockers(projectFiles: [String]) -> [String] {
        var issues: [String] = []
        let lowercased = projectFiles.map { $0.lowercased() }
        if !lowercased.contains(where: { $0.contains("login") }) {
            issues.append("missing login screen")
        }
        if !lowercased.contains(where: { $0.contains("icon") }) {
            issues.append("missing app icon")
        }
        if !lowercased.contains(where: { $0.contains("validation") }) {
            issues.append("no validation logic found")
        }

        return issues
    }
}
