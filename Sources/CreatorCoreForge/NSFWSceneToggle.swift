import Foundation

/// Wrapper for enabling or disabling NSFW scene rendering.
public struct NSFWSceneToggle {
    private let manager: NSFWContentManager

    public init(manager: NSFWContentManager = .shared) {
        self.manager = manager
    }

    /// Check if a scene of the given intensity can be shown.
    public func allow(intensity: NSFWContentManager.NSFWIntensity) -> Bool {
        manager.isSceneAllowed(intensity)
    }

    /// Toggle global NSFW mode using the standard unlock code.
    public func setEnabled(_ enabled: Bool) {
        if enabled {
            manager.unlock(with: "creatoraccess")
        } else {
            manager.unlocked = false
        }
    }
}
