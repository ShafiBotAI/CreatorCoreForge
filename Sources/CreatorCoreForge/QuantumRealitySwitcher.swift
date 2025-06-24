import Foundation

/// Switches between alternate video realities.
public final class QuantumRealitySwitcher {
    public private(set) var currentReality: String
    public init(initialReality: String = "Base") {
        self.currentReality = initialReality
    }

    /// Switch to a different reality and return the active name.
    @discardableResult
    public func switchReality(to reality: String) -> String {
        currentReality = reality
        return currentReality
    }
}
