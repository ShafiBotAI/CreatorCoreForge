import Foundation

/// Tracks unlockable voice skin names.
public final class UnlockableVoiceSkins {
    private var unlocked: Set<String> = []
    public init() {}

    public func unlock(_ name: String) {
        unlocked.insert(name)
    }

    public func isUnlocked(_ name: String) -> Bool {
        unlocked.contains(name)
    }
}
