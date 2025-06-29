import Foundation

public enum LeadFormType {
    case contact
    case signup
    case unknown
}

/// Classifies lead forms based on fields present.
public struct LeadFormClassifier {
    public init() {}

    public func classify(fields: [String]) -> LeadFormType {
        let lower = fields.map { $0.lowercased() }
        if lower.contains("message") {
            return .contact
        } else if lower.contains("password") || lower.contains("confirm password") {
            return .signup
        }
        return .unknown
    }
}
