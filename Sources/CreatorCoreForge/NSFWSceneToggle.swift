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
    /// Age must meet `ContentPolicyManager.ageLimit`.
    public func setEnabled(_ enabled: Bool, age: Int = 0) {
        if enabled {
            manager.verifyAge(age)
            manager.unlock(with: "creatoraccess")
        } else {
            manager.unlocked = false
        }
    }
}
