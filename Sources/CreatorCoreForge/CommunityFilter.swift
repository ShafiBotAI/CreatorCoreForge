import Foundation

/// NSFW content filter with PIN-based toggle.
public final class CommunityFilter {
    public static let shared = CommunityFilter()

    private let defaults: UserDefaults
    private let pinKey = "CF_PIN"
    private let flagKey = "CF_NSFW"
    private var pin: String
    private var nsfwEnabled: Bool

    public init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
        self.pin = userDefaults.string(forKey: pinKey) ?? ""
        self.nsfwEnabled = userDefaults.bool(forKey: flagKey)
    }

    /// Attempt to enable NSFW content. If a PIN is already set, it must match.
    @discardableResult
    public func enableNSFW(pin: String) -> Bool {
        if self.pin.isEmpty {
            self.pin = pin
            nsfwEnabled = true
            persist()
            return true
        }
        guard pin == self.pin else { return false }
        nsfwEnabled = true
        persist()
        return true
    }

    /// Disable NSFW access.
    public func disableNSFW() {
        nsfwEnabled = false
        persist()
    }

    /// Sanitize text when NSFW is not enabled.
    public func filter(_ text: String) -> String {
        nsfwEnabled ? text : ContentPolicyManager.sanitize(text)
    }

    private func persist() {
        defaults.set(pin, forKey: pinKey)
        defaults.set(nsfwEnabled, forKey: flagKey)
    }
}
