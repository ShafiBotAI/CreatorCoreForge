import Foundation

/// Enforces a single upload destination unless unlocked.
public final class UploadLimiter {
    private var allowedPlatform: String?
    private var unlocked: Bool = false

    public init(initialPlatform: String? = nil) {
        self.allowedPlatform = initialPlatform
    }

    /// Checks if uploading to the specified platform is permitted.
    public func canUpload(to platform: String) -> Bool {
        if unlocked { return true }
        if allowedPlatform == nil {
            allowedPlatform = platform
            return true
        }
        return allowedPlatform == platform
    }

    /// Unlocks uploads to multiple platforms via in-app purchase.
    public func unlockAllPlatforms() {
        unlocked = true
    }
}
