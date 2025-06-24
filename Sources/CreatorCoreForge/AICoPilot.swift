import Foundation

/// Provides lightweight AI-assisted code suggestions.
public struct AICoPilot {
    public init() {}

    /// Suggest a simple refactor by detecting TODO comments.
    public func suggestRefactor(for code: String) -> String {
        if code.contains("TODO") {
            return "Consider implementing the TODOs or splitting large methods."
        } else {
            return "No obvious refactor suggestions."
        }
    }

    /// Detect duplicate lines that may indicate redundant logic.
    public func highlightRedundancy(in code: String) -> [String] {
        var duplicates: [String: Int] = [:]
        code.split(separator: "\n").forEach { line in
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard !trimmed.isEmpty else { return }
            duplicates[trimmed, default: 0] += 1
        }
        return duplicates.filter { $0.value > 1 }.map { $0.key }
    }

    /// Suggest whether a block should use async or sync style.
    public func suggestAsyncUsage(for code: String) -> String {
        if code.contains("DispatchQueue") && !code.contains("async") {
            return "Consider using async/await for clearer concurrency."
        }
        return "Sync usage looks fine."
    }

    /// Generate documentation stub for a function name.
    public func generateDocs(for function: String) -> String {
        "/// Documentation for \(function)\n"
    }

    /// Automatically comment a block of code with a simple explanation.
    public func autoComment(code: String, explanation: String) -> String {
        let lines = code.split(separator: "\n")
        return (["/// \(explanation)"] + lines).joined(separator: "\n")
    }
}
