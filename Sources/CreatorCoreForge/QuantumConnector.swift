import Foundation

/// Optional helper that simulates quantum processing for advanced users.
public final class QuantumConnector {
    /// Indicates whether quantum mode is enabled.
    public var isEnabled: Bool

    public init(enabled: Bool = false) {
        self.isEnabled = enabled
    }

    /// Toggles the quantum processing mode.
    public func toggle() {
        isEnabled.toggle()
    }

    /// Returns processed data. When quantum mode is enabled the string is
    /// reversed to simulate a complex transformation.
    public func process(_ data: String) -> String {
        guard isEnabled else { return data }
        return String(data.reversed())
    }
}
