import Foundation

/// Manages global NSFW mode with age verification using `AgeIDVerifier` and persistent
/// storage via `AppSettings`. When enabled, NSFW features become accessible
/// across the app.
public final class NSFWMode {
    private let settings: AppSettings
    private let verifier: AgeIDVerifier

    public init(settings: AppSettings = .shared,
                verifier: AgeIDVerifier = AgeIDVerifier()) {
        self.settings = settings
        self.verifier = verifier
    }

    /// Indicates whether NSFW mode is currently active and verified.
    public var isEnabled: Bool {
        settings.allowNSFW && verifier.isVerified
    }

    /// Attempts to enable NSFW mode by validating the provided birthdate
    /// and ID number. Returns `true` on success.
    @discardableResult
    public func enable(birthdate: Date, idNumber: String) -> Bool {
        guard verifier.verify(birthdate: birthdate, idNumber: idNumber) else {
            return false
        }
        settings.allowNSFW = true
        settings.save()
        return true
    }

    /// Disables NSFW mode and persists the updated setting.
    public func disable() {
        settings.allowNSFW = false
        settings.save()
    }

    /// Returns true if the provided text is allowed under the current NSFW settings.
    /// Unsafe content is blocked when NSFW mode is disabled.
    public func isTextAllowed(_ text: String) -> Bool {
        guard !isEnabled else { return true }
        return !NSFWModerationFlagger().flag(text)
    }
}
