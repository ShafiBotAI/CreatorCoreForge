import Foundation

/// Generates simple alerts for major market events.
public final class AIAlertService {
    public init() {}

    /// Returns an alert message for a whale movement or event.
    public func alert(for event: String) -> String {
        return "ALERT: \(event)"
    }
}
