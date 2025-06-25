import Foundation

/// Manages a simple referral program shared across all apps.
public final class ReferralProgram {
    public static let shared = ReferralProgram()

    /// Editable info for the referral program.
    public struct ProgramInfo: Equatable {
        public var terms: String
        public init(terms: String = "Standard referral rewards apply.") {
            self.terms = terms
        }
    }

    private var info: ProgramInfo
    private var infoByApp: [String: ProgramInfo] = [:]
    private var stats: [String: Int] = [:]

    public init(info: ProgramInfo = .init()) {
        self.info = info
    }

    /// Create a referral code for a given identifier (e.g., email).
    public func createCode(for identifier: String) -> String {
        let base = (identifier + UUID().uuidString).data(using: .utf8)!
        let code = String(base.base64EncodedString().prefix(8))
        stats[code] = 0
        return code
    }

    /// Record a signup for the referral code.
    public func registerSignup(code: String) {
        stats[code, default: 0] += 1
    }

    /// Return total signups for a code.
    public func signups(for code: String) -> Int {
        stats[code] ?? 0
    }

    /// Update program terms. When `app` is provided, update terms only for that app.
    public func updateTerms(_ newTerms: String, forApp app: String? = nil) {
        if let app = app {
            infoByApp[app] = ProgramInfo(terms: newTerms)
        } else {
            info.terms = newTerms
        }
    }

    /// Current program info. When `app` is provided, returns app-specific terms if set.
    public func currentInfo(forApp app: String? = nil) -> ProgramInfo {
        if let app = app, let appInfo = infoByApp[app] {
            return appInfo
        }
        return info
    }

    /// All referral statistics.
    public func allStats() -> [String: Int] {
        stats
    }
}
