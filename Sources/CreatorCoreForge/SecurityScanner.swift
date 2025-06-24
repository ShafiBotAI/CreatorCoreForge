import Foundation

/// Performs very basic code scanning for potential vulnerabilities.
public struct SecurityScanner {
    public init() {}

    /// Returns `true` if no banned patterns are found.
    public func scan(code: String) -> Bool {
        let banned = ["eval(", "exec(", "system("]
        return !banned.contains { code.contains($0) }
    }

    /// Scan code for simple web injection patterns and return detected issues.
    public func advancedScan(code: String) -> [String] {
        var issues: [String] = []
        if code.contains("<script>") { issues.append("XSS") }
        if code.contains("document.cookie") { issues.append("CSRF") }
        if code.contains("token=") { issues.append("TokenLeak") }
        return issues
    }
}
