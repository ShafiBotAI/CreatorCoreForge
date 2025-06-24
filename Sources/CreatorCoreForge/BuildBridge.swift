import Foundation
import CreatorCoreForge

/// Provides a minimal Swift wrapper around BuildImprovementEngine
/// for iOS integration tests.
public final class BuildBridge {
    private let engine = BuildImprovementEngine()

    public init() {}

    /// Scan project files and return detected issues.
    public func scan(path: String) -> [String] {
        engine.scanProject(at: path)
    }

    /// Attempt to auto-fix missing code markers.
    @discardableResult
    public func fix(path: String) -> Int {
        engine.fixMissingCode(at: path)
    }
}
