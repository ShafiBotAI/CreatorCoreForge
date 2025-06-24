import Foundation

/// Performs very basic code scanning for potential vulnerabilities.
public struct SecurityScanner {
    public init() {}

    /// Returns `true` if no banned patterns are found.
    public func scan(code: String) -> Bool {
        let banned = ["eval(", "exec(", "system("]
        return !banned.contains { code.contains($0) }
    }
}
