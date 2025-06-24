import Foundation

/// NSFW content filter with PIN-based toggle.
public final class CommunityFilter {
    public static let shared = CommunityFilter()

    private let defaults: UserDefaults
    private let pinKey = "CF_PIN"
    private let flagKey = "CF_NSFW"
    private let regionKey = "CF_REGION"
    private var pin: String
    private var nsfwEnabled: Bool
    private var region: String
    private var blockedRegions: Set<String>

    public init(userDefaults: UserDefaults = .standard,
                region: String? = nil,
                blockedRegions: Set<String> = []) {
        self.defaults = userDefaults
        self.pin = userDefaults.string(forKey: pinKey) ?? ""
        self.nsfwEnabled = userDefaults.bool(forKey: flagKey)
        self.region = userDefaults.string(forKey: regionKey) ?? region ?? Locale.current.regionCode ?? "US"
        self.blockedRegions = blockedRegions
    }

    /// Attempt to enable NSFW content. If a PIN is already set, it must match.
    /// Returns false when the user's region is blocked.
    @discardableResult
    public func enableNSFW(pin: String) -> Bool {
        guard isRegionAllowed() else { return false }
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

    /// Change the current region code.
    public func setRegion(_ code: String) {
        region = code
        persist()
    }

    /// Returns true if the user's region allows NSFW content.
    public func isRegionAllowed() -> Bool {
        return !blockedRegions.contains(region)
    }

    private func persist() {
        defaults.set(pin, forKey: pinKey)
        defaults.set(nsfwEnabled, forKey: flagKey)
        defaults.set(region, forKey: regionKey)
    }
}
