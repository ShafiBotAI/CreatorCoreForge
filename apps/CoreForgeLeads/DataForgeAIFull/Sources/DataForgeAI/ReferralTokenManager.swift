import Foundation

/// Generates simple referral tokens for lead exchanges.
public struct ReferralTokenManager {
    public init() {}

    public func createToken(for email: String, salt: String = "") -> String {
        let combined = (email + salt).lowercased()
        let base = combined.data(using: .utf8)?.base64EncodedString() ?? combined
        return String(base.prefix(8))
    }

    public func validate(token: String, for email: String, salt: String = "") -> Bool {
        createToken(for: email, salt: salt) == token
    }
}
