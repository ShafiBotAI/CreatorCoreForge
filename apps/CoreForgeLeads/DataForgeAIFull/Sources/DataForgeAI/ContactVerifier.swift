import Foundation

/// Verifies contacts and returns a simple bounce risk score.
public struct ContactVerifier {
    public init() {}

    /// Basic check for valid email formatting. Returns risk from 0 (low) to 1 (high).
    public func bounceRisk(for email: String) -> Double {
        let pattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        let range = NSRange(email.startIndex..<email.endIndex, in: email)
        let matches = regex?.numberOfMatches(in: email, options: [], range: range) ?? 0
        return matches == 1 ? 0.0 : 1.0
    }
}
