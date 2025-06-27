import Foundation

/// Provides a minimal Swift wrapper around BuildImprovementEngine
/// for iOS integration tests.
public final class BuildBridge {
    private let engine = BuildImprovementEngine()

    public init() {}

    /// Scan project files and return detected issues.
    public func scan(path: String) -> [String] {
        return engine.scanProject(at: path)
    }

    /// Attempt to auto-fix missing code markers.
    @discardableResult
    public func fix(path: String) -> Int {
        return engine.fixMissingCode(at: path)
    }
}
