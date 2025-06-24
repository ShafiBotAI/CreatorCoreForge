import Foundation

/// Performs simple compliance checks for CoreForge Build.
public struct ComplianceChecker {
    public init() {}
    
    /// Ensure required policy docs exist.
    public func validatePrivacyDocs(at path: String) -> Bool {
        let required = ["PrivacyPolicy.md", "TermsOfService.md"]
        return required.allSatisfy { FileManager.default.fileExists(atPath: path + "/" + $0) }
    }
    
    /// Generate a summary compliance report.
    public func generateReport(for path: String) -> [String: Bool] {
        ["privacyDocs": validatePrivacyDocs(at: path)]
    }
}
