import Foundation

/// Coordinates self-code repair across all CoreForge apps using `BuildImprovementEngine`.
public final class SelfRepairEngine {
    private let improvement = BuildImprovementEngine()

    public init() {}

    /// Scan each app directory under the given repository root and report issues.
    public func reportIssues(at root: String) -> [String] {
        var issues: [String] = []
        let appsDir = (root as NSString).appendingPathComponent("apps")
        if let apps = try? FileManager.default.contentsOfDirectory(atPath: appsDir) {
            for app in apps {
                let path = (appsDir as NSString).appendingPathComponent(app)
                issues += improvement.scanProject(at: path)
            }
        }
        return issues
    }

    /// Attempt to automatically fix missing code across all app directories.
    /// - Returns: The total number of files updated.
    @discardableResult
    public func repairAllApps(at root: String) -> Int {
        var updated = 0
        let appsDir = (root as NSString).appendingPathComponent("apps")
        if let apps = try? FileManager.default.contentsOfDirectory(atPath: appsDir) {
            for app in apps {
                let path = (appsDir as NSString).appendingPathComponent(app)
                updated += improvement.fixMissingCode(at: path)
            }
        }
        return updated
    }
}
