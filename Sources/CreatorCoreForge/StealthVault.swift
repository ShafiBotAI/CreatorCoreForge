import Foundation

/// Simple vault utility with password-based activation for NSFW audio.
public final class StealthVault {
    private let passwordHash: Int = "secret123".hashValue

    public init() {}

    /// Returns true when the provided password matches the stored hash.
    public func activate(password: String) -> Bool {
        return password.hashValue == passwordHash
    }

    public func lockContent() {
        print("Vault locked.")
    }

    public func unlockContent() {
        print("Vault unlocked.")
    }
}
