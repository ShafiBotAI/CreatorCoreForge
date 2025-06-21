import Foundation

/// Handles activation of a decoy screen for secret mode sessions.
public final class DecoyScreenManager {
    public static let shared = DecoyScreenManager()
    private(set) var active = false

    private init() {}

    /// Enable the decoy screen.
    public func enable() {
        active = true
    }

    /// Disable the decoy screen.
    public func disable() {
        active = false
    }

    /// Query decoy screen state.
    public func isActive() -> Bool { active }
}

