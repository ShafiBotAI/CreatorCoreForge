import Foundation

/// Scans existing projects and suggests improvements for CoreForge Build.
public final class BuildImprovementEngine {
    private let security = SecurityScanner()
    private let compliance = ComplianceChecker()
    private let copilot = AICoPilot()

    public init() {}

    /// Scan project files for missing implementations and potential issues.
    public func scanProject(at path: String) -> [String] {
        var issues: [String] = []
        guard let files = FileManager.default.enumerator(atPath: path) else {
            return issues
        }
        for case let file as String in files {
            if file.hasSuffix(".swift") || file.hasSuffix(".js") || file.hasSuffix(".ts") {
                let full = (path as NSString).appendingPathComponent(file)
                guard let code = try? String(contentsOfFile: full) else { continue }
                if !security.scan(code: code) {
                    issues.append("Potential vulnerability in \(file)")
                }
                if code.contains("TODO") || code.contains("Not implemented") {
                    issues.append("Missing implementation in \(file)")
                }
                let hint = copilot.suggestRefactor(for: code)
                if hint != "No obvious refactor suggestions." {
                    issues.append("Refactor suggestion for \(file): \(hint)")
                }
            }
        }
        return issues
    }

    /// Replace simple not-implemented markers with TODO comments.
    @discardableResult
    public func fixMissingCode(at path: String) -> Int {
        var updated = 0
        guard let files = FileManager.default.enumerator(atPath: path) else { return updated }
        for case let file as String in files {
            if file.hasSuffix(".swift") {
                let full = (path as NSString).appendingPathComponent(file)
                guard var code = try? String(contentsOfFile: full) else { continue }
                if code.contains("fatalError(\"Not implemented\")") {
                    code = code.replacingOccurrences(of: "fatalError(\"Not implemented\")", with: "// TODO: implement\n    return")
                    try? code.write(toFile: full, atomically: true, encoding: .utf8)
                    updated += 1
                }
            }
        }
        return updated
    }

    /// Recommend feature enhancements based on existing feature names.
    public func recommendEnhancements(for features: [String]) -> [String] {
        var output: [String] = []
        for feat in features {
            let lower = feat.lowercased()
            if lower.contains("login") { output.append("Add two-factor authentication") }
            if lower.contains("analytics") { output.append("Provide real-time analytics dashboard") }
            if lower.contains("chat") { output.append("Enable message history search") }
        }
        return output
    }

    /// Validate that required compliance docs exist for a project path.
    public func validateCompliance(at path: String) -> Bool {
        compliance.validatePrivacyDocs(at: path)
    }
}

