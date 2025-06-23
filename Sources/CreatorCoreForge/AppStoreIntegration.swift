import Foundation

/// Basic receipt validator used for testing subscription flows.
/// The receipt is expected to contain JSON with an `expires` timestamp.
public struct AppStoreIntegration {
    public init() {}

    public func validateReceipt(_ data: Data) -> Bool {
        guard
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let expires = json["expires"] as? TimeInterval
        else { return false }
        return Date().timeIntervalSince1970 < expires
    }
}
